//
//  MyDetailViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/29.
//

import UIKit
import FirebaseAuth

class MyDetailViewController: BaseViewController {
    let mainView = MyDetailView()
    var viewModel: MyViewModel!
    
    var isOpen = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "정보관리"
        
        mainView.customUserInfoTabelView.delegate = self
        mainView.customUserInfoTabelView.dataSource = self
        mainView.customUserInfoTabelView.register(CustomUserInfoCell.self, forCellReuseIdentifier: CustomUserInfoCell.identifier)
        
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
        
        cell.customUserInfoName.nameLabel.text = "get.user.nick"
        
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
