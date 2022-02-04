//
//  MyDetailViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/29.
//

//Todo
//MyDetailBottomView 클릭시 이벤트 연결
//번호 검색 허용 처리 안되었음
//연령대 슬라이더 처리 안되었음
//저장 버튼 클릭시 통신처리 안되었음

import UIKit
import FirebaseAuth
import CloudKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "정보관리"
        self.navigationItem.rightBarButtonItem = self.barButton
        
        mainView.customUserInfoTabelView.delegate = self
        mainView.customUserInfoTabelView.dataSource = self
        mainView.customUserInfoTabelView.register(CustomUserInfoCell.self, forCellReuseIdentifier: CustomUserInfoCell.identifier)
        
        mainView.withdrawButton.addTarget(self, action: #selector(withdrawButtonClicked), for: .touchUpInside)
    }
    
    @objc func barButtonClicked() {
        print("BarButtonClicked")
    }
    
    @objc func withdrawButtonClicked() {
        let vc = CustomAlertViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.viewModel = self.viewModel
        present(vc, animated: true, completion: nil)
    }
    
    @objc func toggleButtonClicked() {
        print("클릭")
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
        
        viewModel.userInfo.bind { UserInfo in
            cell.customUserInfoName.nameLabel.text = UserInfo.nick
        }
        
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
