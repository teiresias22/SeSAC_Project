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
        let vc = NearUserViewController()
        vc.viewModel = self.viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            DispatchQueue.main.async {
                self.mainView.submitButton.snp.makeConstraints { make in
                    make.bottom.equalToSuperview().inset(keyboardSize.height)
                    make.leading.trailing.equalToSuperview()
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
            }
        }
        return true
    }
}

extension HobbyViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.topColectionView {
            return viewModel.fromRecommendHobby.value.count
        } else if collectionView == mainView.bottomColectionView {
            return viewModel.fromMyHobby.value.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.topColectionView {
            guard let item = mainView.topColectionView.dequeueReusableCell(withReuseIdentifier: HobbyViewControllerCellId, for: indexPath) as? HobbyCollectionViewCell else { return UICollectionViewCell() }
            item.textLabel.text = viewModel.fromRecommendHobby.value[indexPath.row]
            
            if indexPath.row < 3 {
                item.textLabel.textColor = .error
                item.textLabel.layer.borderColor = UIColor.error?.cgColor
            } else {
                item.textLabel.textColor = .customBlack
                item.textLabel.layer.borderColor = UIColor.customGray4?.cgColor
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
        if collectionView == mainView.bottomColectionView {
            myHobby.remove(at: indexPath.row)
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
