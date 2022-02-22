//
//  HobbyViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/05.
//

import UIKit
import FirebaseAuth

class HobbyViewController: BaseViewController {
    let mainView = HobbyView()
    var viewModel: HomeViewModel!
    
    private let HobbyViewControllerCellId = "HobbyViewControllerCellId"
    
    var myHobby: [String] = []
    var newHobby: [String] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        
        mainView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        mainView.submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
        mainView.searchBar.searchTextField.addTarget(self, action: #selector(searchTextFieldEditingChanged), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: self.view.window)
    }
    
    func setCollectionView() {
        mainView.topColectionView.delegate = self
        mainView.topColectionView.dataSource = self
        mainView.topColectionView.register(HobbyCollectionViewCell.self, forCellWithReuseIdentifier: HobbyViewControllerCellId)
        
        mainView.bottomColectionView.delegate = self
        mainView.bottomColectionView.dataSource = self
        mainView.bottomColectionView.register(HobbyCollectionViewCell.self, forCellWithReuseIdentifier: HobbyViewControllerCellId)
    }
    
    @objc func backButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func searchTextFieldEditingChanged(){
        myHobby = mainView.searchBar.searchTextField.text?.components(separatedBy: " ").filter({ text in
            text.count > 0
        }) ?? []
        
        print("myHobby",myHobby)
        print("newHobby",newHobby)
        checkMyHobbyValidation(newHobbys: newHobby)
    }
    
    @objc func submitButtonClicked() {
        mainView.searchBar.searchTextField.endEditing(true)
        
        if myHobby.count == 0 {
            toastMessage(message: "취미를 하나 이상 입력해주세요.")
        } else {
            let form = PostQueueForm(type: viewModel.searchGender.value, region: viewModel.centerRegion.value, lat: viewModel.centerLatitude.value, long: viewModel.centerLongitude.value, hf: viewModel.fromMyHobby.value)
            viewModel.postQueue(form: form) { statuscode, error in
                guard let statuscode = statuscode else {
                    return
                }
                
                switch statuscode {
                case QueueStataCodeCase.success.rawValue:
                    UserDefaults.standard.set(MyStatusCase.matching.rawValue, forKey: UserDefault.myStatus.rawValue)
                    
                    let form = OnQueueForm(region: self.viewModel.centerRegion.value, lat: self.viewModel.centerLatitude.value, long: self.viewModel.centerLongitude.value)
                    self.viewModel.searchNearFriends(form: form) { onqueueResult, statuscode, error in
                        guard let onqueueResult = onqueueResult else {
                            return
                        }
                        
                        switch self.viewModel.searchGender.value {
                        case GenderCode.man.rawValue, GenderCode.woman.rawValue:
                            self.viewModel.filteredQueueDB.value = onqueueResult.fromQueueDB.filter({ result in
                                result.gender == self.viewModel.searchGender.value
                            })
                        default:
                            self.viewModel.filteredQueueDB.value = onqueueResult.fromQueueDB
                        }
                        let vc = NearUserViewController()
                        vc.viewModel = self.viewModel
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                case QueueStataCodeCase.blockedUser.rawValue:
                    self.toastMessage(message: "신고가 누적되어 이용할수 없습니다.")
                case QueueStataCodeCase.cancelPanlty1.rawValue:
                    self.toastMessage(message: "약속취소 패널티로 1분동안 이용이 제한됩니다.")
                case QueueStataCodeCase.cancelPanlty2.rawValue:
                    self.toastMessage(message: "약속취소 패널티로 2분동안 이용이 제한됩니다.")
                case QueueStataCodeCase.cancelPanlty3.rawValue:
                    self.toastMessage(message: "약속취소 패널티로 3분동안 이용이 제한됩니다.")
                case QueueStataCodeCase.invalidGender.rawValue:
                    self.toastMessage(message: "새싹 찾기 기능을 이용하기 위해서는 성별이 필요해요!")
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        self.present(MyDetailViewController(), animated: true) {
                            self.viewModel.getUserInfo { userInfo, statuscode, error in
                                if let userInfo = userInfo {
                                    self.mainView.topColectionView.reloadData()
                                    self.mainView.bottomColectionView.reloadData()
                                }
                            }
                        }
                    }
                case QueueStataCodeCase.firebaseTokenError.rawValue:
                    self.refreshFirebaseIdToken { idToken, error in
                        if let idToken = idToken {
                            self.submitButtonClicked()
                        }
                    }
                default:
                    self.toastMessage(message: "잠시후 다시 시도해주세요!")
                }
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            DispatchQueue.main.async {
                self.mainView.submitButton.snp.makeConstraints { make in
                    make.bottom.equalToSuperview().inset(keyboardSize.height)
                    make.leading.trailing.equalToSuperview().inset(-8)
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        DispatchQueue.main.async {
            self.mainView.submitButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview().inset(50)
                make.leading.trailing.equalToSuperview().inset(16)
            }
        }
    }
    
    func checkMyHobbyValidation(newHobbys: [String]) -> Bool {
        if myHobby.count + newHobby.count  > 8 {
            toastMessage(message: "취미를 더 추가할 수 없습니다.")
            return false
        }
        for hobby in newHobbys {
            if hobby.count > 8 {
                toastMessage(message: "취미는 최대 8자까지 가능합니다.")
                return false
            }
        }
        return true
    }
}

//MARK: CollectionView Set
extension HobbyViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == mainView.topColectionView {
            return 2
        } else {
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.topColectionView {
            switch section {
            case 0:
                return viewModel.fromRecommendHobby.value.count
            case 1:
                return viewModel.fromNearFriendsHobby.value.count
            default:
                return 0
            }
        } else {
            return viewModel.fromMyHobby.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.topColectionView {
            guard let item = mainView.topColectionView.dequeueReusableCell(withReuseIdentifier: HobbyViewControllerCellId, for: indexPath) as? HobbyCollectionViewCell else { return UICollectionViewCell() }
            
            switch indexPath.section {
            case 0:
                item.textLabel.textColor = .error
                item.textLabel.layer.borderColor = UIColor.error?.cgColor
                item.textLabel.text = viewModel.fromRecommendHobby.value[indexPath.row]
            case 1:
                item.textLabel.textColor = .customBlack
                item.textLabel.layer.borderColor = UIColor.customGray4?.cgColor
                item.textLabel.text = viewModel.fromNearFriendsHobby.value[indexPath.row]
            default:
                item.textLabel.text = ""
            }
            return item
        } else {
            guard let item = mainView.bottomColectionView.dequeueReusableCell(withReuseIdentifier: HobbyViewControllerCellId, for: indexPath) as? HobbyCollectionViewCell else { return UICollectionViewCell() }
            item.textLabel.text = viewModel.fromMyHobby.value[indexPath.row]
            item.textLabel.textColor = .customGreen
            item.textLabel.layer.borderColor = UIColor.customGreen?.cgColor
            
            return item
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainView.topColectionView {
            if checkMyHobbyValidation(newHobbys: []) {
                if !myHobby.contains(viewModel.fromRecommendHobby.value[indexPath.row]){
                    myHobby.append(viewModel.fromRecommendHobby.value[indexPath.row])
                }
            }
        } else {
            if let index = myHobby.firstIndex(of: myHobby[indexPath.row]) {
                myHobby.remove(at: index)
            }
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
