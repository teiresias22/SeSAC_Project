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
    var switchIsOn = false
    
    var nick = ""
    var gender = -1
    var hobby = ""
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "정보관리"
        self.navigationItem.rightBarButtonItem = self.barButton
        
        checkUserData()
        
        mainView.customUserInfoTabelView.delegate = self
        mainView.customUserInfoTabelView.dataSource = self
        mainView.customUserInfoTabelView.register(CustomUserInfoCell.self, forCellReuseIdentifier: CustomUserInfoCell.identifier)
        
        mainView.withdrawButton.addTarget(self, action: #selector(withdrawButtonClicked), for: .touchUpInside)
        mainView.myDetailBottomView.manButton.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
        mainView.myDetailBottomView.womanButton.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
        mainView.myDetailBottomView.allowSearchSwitch.addTarget(self, action: #selector(allowSearchSwitchChanged), for: .touchUpInside)
        
        mainView.myDetailBottomView.ageSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    func checkUserData(){
        viewModel.userInfo.bind { UserInfo in
            self.nick = UserInfo.nick
            self.gender = UserInfo.gender
            self.hobby = UserInfo.hobby
        }
    }
    
    func setgenderButton() {
        if gender == -1 {
            buttonDeactive(mainView.myDetailBottomView.manButton)
            buttonDeactive(mainView.myDetailBottomView.womanButton)
        } else if gender == 0 {
            buttonActive(mainView.myDetailBottomView.womanButton)
            buttonDeactive(mainView.myDetailBottomView.manButton)
        } else if gender == 1 {
            buttonActive(mainView.myDetailBottomView.manButton)
            buttonDeactive(mainView.myDetailBottomView.womanButton)
        }
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
        buttonActive(mainView.myDetailBottomView.manButton)
        buttonDeactive(mainView.myDetailBottomView.womanButton)
    }
    
    @objc func womanButtonClicked() {
        buttonActive(mainView.myDetailBottomView.womanButton)
        buttonDeactive(mainView.myDetailBottomView.manButton)
    }
    
    @objc func allowSearchSwitchChanged() {
        switchIsOn.toggle()
        //번호 검색 허용하기, searchable에서 가져오기
    }
    
    @objc func sliderValueChanged(_ sender: UISlider!) {
        print("sliderValue", mainView.myDetailBottomView.ageSlider.value)
        //multislider 적용하기, ageMin, ageMax에서 가져오기
    }
    
    @objc func barButtonClicked() {
        print("BarButtonClicked")
        //updateMypage 해야함
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
        
        if isOpen {
            cell.customUserInfoTitle.isHidden = false
            cell.customUserInfoHobby.isHidden = true
            cell.customUserInfoReview.isHidden = false
            
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
        cell.customUserInfoName.nameLabel.text = nick
        
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
