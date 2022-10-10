//
//  MyDetailViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/29.
//

//Todo
//번호 검색 허용 처리 안되었음
//연령대 슬라이더 처리 안되었음
//저장 버튼 클릭시 통신처리 안되었음

import UIKit
import FirebaseAuth

class MyDetailViewController: BaseViewController {
    let mainView = MyDetailView()
    var viewModel: MyViewModel!
    
    var barButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(barButtonClicked))
        button.tintColor = .customBlack
        
        return button
    }()
    
    var isOpen = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async { // [weak self]클로저 캡쳐리스트
            self.viewModel.getUserInfo { userInfo, status, error in
                guard let userInfo = userInfo else {
                    return
                }
                print("userInfo", userInfo, self.viewModel.userInfo)
                
                self.viewModel.userInfo.value = userInfo
                self.viewModel.updateObservable()
                
                self.viewModel.userInfo.bind { userInfo in
                    switch userInfo.gender {
                    case GenderCode.man.rawValue:
                        self.buttonActive(self.mainView.myDetailBottomView.manButton)
                        self.buttonDeactive(self.mainView.myDetailBottomView.womanButton)
                    case GenderCode.woman.rawValue:
                        self.buttonActive(self.mainView.myDetailBottomView.womanButton)
                        self.buttonDeactive(self.mainView.myDetailBottomView.manButton)
                    default:
                        self.buttonDeactive(self.mainView.myDetailBottomView.manButton)
                        self.buttonDeactive(self.mainView.myDetailBottomView.womanButton)
                    }
                    
                    self.mainView.myDetailBottomView.hobbyInputTextfield.text = userInfo.hobby
                    self.mainView.myDetailBottomView.allowSearchSwitch.isOn = userInfo.searchable == 0 ? false : true
                    self.viewModel.searchable.value = userInfo.searchable
                    self.mainView.myDetailBottomView.ageLabel.text = "\(userInfo.ageMin) - \(userInfo.ageMax)"
                    
                    self.mainView.myDetailBottomView.ageSlider.minimumValue = Float(userInfo.ageMin)
                    self.mainView.myDetailBottomView.ageSlider.maximumValue = Float(userInfo.ageMax)
                    
                    self.mainView.myDetailBottomView.reloadInputViews()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "정보관리"
        self.navigationItem.rightBarButtonItem = self.barButton
        
        
        mainView.customUserInfoTabelView.delegate = self
        mainView.customUserInfoTabelView.dataSource = self
        mainView.customUserInfoTabelView.register(CustomUserInfoCell.self, forCellReuseIdentifier: CustomUserInfoCell.identifier)
        
        mainView.withdrawButton.addTarget(self, action: #selector(withdrawButtonClicked), for: .touchUpInside)
        mainView.myDetailBottomView.manButton.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
        mainView.myDetailBottomView.womanButton.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
        mainView.myDetailBottomView.allowSearchSwitch.addTarget(self, action: #selector(allowSearchSwitchChanged), for: .valueChanged)
        mainView.myDetailBottomView.hobbyInputTextfield.addTarget(self, action: #selector(hobbyTextFieldDidChange(_:)), for: .editingChanged)
        mainView.myDetailBottomView.ageSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    func buttonActive(_ target: UIButton) {
        target.backgroundColor = .customGreen
        target.setTitleColor(.customWhite, for: .normal)
        target.layer.borderWidth = 0
    }
    
    func buttonDeactive(_ target: UIButton) {
        target.backgroundColor = .customWhite
        target.setTitleColor(.customBlack, for: .normal)
        target.layer.borderWidth = 1
        
    }
    
    //MARK: ClickAction
    @objc func manButtonClicked() {
        viewModel.gender.value = GenderCode.man.rawValue
        buttonActive(mainView.myDetailBottomView.manButton)
        buttonDeactive(mainView.myDetailBottomView.womanButton)
    }
    
    @objc func womanButtonClicked() {
        viewModel.gender.value = GenderCode.woman.rawValue
        buttonActive(mainView.myDetailBottomView.womanButton)
        buttonDeactive(mainView.myDetailBottomView.manButton)
    }
    
    @objc func allowSearchSwitchChanged() {
        mainView.myDetailBottomView.allowSearchSwitch.isOn.toggle()
        viewModel.searchable.value = mainView.myDetailBottomView.allowSearchSwitch.isOn == true ? 1 : 0
    }
    
    @objc func hobbyTextFieldDidChange(_ textField: UITextField) {
        viewModel.hobby.value = textField.text ?? ""
    }
    
    @objc func sliderValueChanged(_ sender: UISlider!) {
        print("sliderValue", mainView.myDetailBottomView.ageSlider.value)
        //multislider 적용하기, ageMin, ageMax에서 가져오기
    }
    
    @objc func barButtonClicked() {
        let updateMypageForm = UpdateUserInfoForm(searchable: viewModel.searchable.value, ageMin: viewModel.ageMin.value, ageMax: viewModel.ageMax.value, gender: viewModel.gender.value, hobby: viewModel.hobby.value)
                viewModel.updateMypage(form: updateMypageForm) { statuscode in
                    switch statuscode {
                    case UserStatusCodeCase.success.rawValue :
                        self.toastMessage(message: "수정이 완료되었습니다")
                        
                    case UserStatusCodeCase.firebaseTokenError.rawValue :
                        self.refreshFirebaseIdToken { idToken, error in
                            self.viewModel.updateMypage(form: updateMypageForm) { statuscode in
                                switch statuscode {
                                case UserStatusCodeCase.success.rawValue:
                                    self.toastMessage(message: "수정이 완료되었습니다")
                                default:
                                    self.toastMessage(message: "내 정보 수정에 실패했습니다. 잠시 후에 다시 시도해주세요")
                                }
                            }
                        }
                    default :
                        self.toastMessage(message: "내 정보 수정에 실패했습니다. 잠시 후에 다시 시도해주세요")
                    }
                }
    }
    
    @objc func withdrawButtonClicked() {
        let vc = CustomAlertViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.viewModel = self.viewModel
        present(vc, animated: true, completion: nil)
    }
    
    @objc func toggleButtonClicked() {
        isOpen = !isOpen
        mainView.customUserInfoTabelView.reloadData()
    }
    
}

extension MyDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomUserInfoCell.identifier) as? CustomUserInfoCell else { return UITableViewCell() }
        
        cell.customUserInfoHobby.isHidden = true
        
        if isOpen {
            cell.customUserInfoTitle.isHidden = isOpen
            cell.customUserInfoReview.isHidden = isOpen
            
            DispatchQueue.main.async {
                cell.customUserInfoHobby.snp.makeConstraints { make in
                    make.height.equalTo(0)
                }
                self.mainView.customUserInfoTabelView.snp.updateConstraints { make in
                    make.height.equalTo(self.mainView.customUserInfoTabelView.contentSize.height)
                }
            }
        } else {
            cell.customUserInfoTitle.isHidden = true
            cell.customUserInfoHobby.isHidden = true
            cell.customUserInfoReview.isHidden = true
            
            DispatchQueue.main.async {
                cell.customUserInfoHobby.snp.makeConstraints { make in
                    make.height.equalTo(0)
                }
                self.mainView.customUserInfoTabelView.snp.updateConstraints { make in
                    make.height.equalTo(self.mainView.customUserInfoTabelView.contentSize.height)
                }
            }
        }
        cell.customUserInfoName.nameLabel.text = viewModel.userInfo.value.nick
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isOpen {
            return 350
        } else {
            return 60
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isOpen.toggle()
        
        tableView.reloadData()
    }
}
