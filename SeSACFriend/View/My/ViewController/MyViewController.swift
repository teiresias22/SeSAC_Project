//
//  MyViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/27.
//

//Todo
//유저 정보를 가져와야 함
//Get을 사용해서 유저 정보를 가져와야 이름과 설정을 가져올텐데
//요거는 조금만 더 공부해서 적용하도록 하자
//목표는 설 연휴 끝나기 전까지!!!!

//어째 네비게이션바가 두개가 중복된것 같다?? 뭐가 어디서부터 잘못 된걸까??

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
