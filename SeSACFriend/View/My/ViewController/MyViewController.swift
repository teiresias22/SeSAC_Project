//
//  MyViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/27.
//

//Todo

import UIKit
import FirebaseAuth

class MyViewController: BaseViewController {
    let mainView = MyView()
    let viewModel = MyViewModel()
    
    override func loadView() {
        self.view = mainView
        
        DispatchQueue.main.async {
            self.viewModel.getUserInfo { userInfo, status, error in
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "내정보"
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MyProfileTableViewCell.self, forCellReuseIdentifier: MyProfileTableViewCell.identifier)
        mainView.tableView.register(MyMenuTableViewCell.self, forCellReuseIdentifier: MyMenuTableViewCell.identifier)
        
        viewModel.userInfo.bind { UserInfo in
            self.mainView.tableView.reloadData()
        }
    }
}

extension MyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            //내정보 셀 만들어서 연결
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyProfileTableViewCell.identifier) as? MyProfileTableViewCell else { return UITableViewCell()}
            
            viewModel.userInfo.bind { UserInfo in
                cell.userNameLabel.text = UserInfo.nick
            }
            cell.selectionStyle = .none
            
            return cell
        } else {
            //하단 항목 셀 만들어서 연결 : 지금은 구현은 안되었지만 추후에 구현될수 있음을 염두해둘것
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyMenuTableViewCell.identifier) as? MyMenuTableViewCell else { return UITableViewCell()}
            
            cell.iconView.image = viewModel.cellForRowAt(indexPath: indexPath).0
            cell.titleLabel.text = viewModel.cellForRowAt(indexPath: indexPath).1
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = MyDetailViewController()
            vc.viewModel = self.viewModel
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.toastMessage(message: "해당 메뉴는 준비중입니다.")
        }
    }
}
