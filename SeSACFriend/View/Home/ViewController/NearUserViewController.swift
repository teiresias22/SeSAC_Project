//
//  NearUserViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/05.
//

//Todo LIST
//찾기 중단 버튼 클릭이벤트
//요청하기, 수락하기 버튼 클릭이벤트
//취미 변경하기, 새로고침 클릭 이벤트
//서버통신

import UIKit
import FirebaseAuth
import CoreLocation

class NearUserViewController: BaseViewController {
    let mainView = NearUserView()
    var viewModel: HomeViewModel!
    
    let refreshControl = UIRefreshControl()
    
    //임시로 넣어둠
    var findUser = 3
    var requestUser = 1
    
    var nowDisplay = true

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        initRefresh()
        
        checkFindUser()
        
        mainView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        mainView.stopButton.addTarget(self, action: #selector(stopButtonClicked), for: .touchUpInside)
        mainView.nearUserButton.addTarget(self, action: #selector(nearUserButtonClicked), for: .touchUpInside)
        mainView.requestRecivedButton.addTarget(self, action: #selector(requestRecivedButtonClicked), for: .touchUpInside)
    }
    
    func setTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(NearUserViewCell.self, forCellReuseIdentifier: NearUserViewCell.identifier)
    }
    
    //당겨서 새로고침
    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        
        refreshControl.backgroundColor = .customGreen
        refreshControl.attributedTitle = NSAttributedString(string: "새로고침")
        mainView.tableView.refreshControl = refreshControl
        
        self.refreshFriends()
    }
    
    @objc func refreshTable(refresh: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.mainView.tableView.reloadData()
            refresh.endRefreshing()
        }
    }
    
    @objc func backButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func stopButtonClicked() {
        print("stopButtonClicked")
        
        viewModel.deleteQueue { statusCode, error in
            switch statusCode {
            case DeleteQueueStatusCodeCase.success.rawValue:
                UserDefaults.standard.set(MyStatusCase.normal.rawValue, forKey: UserDefault.myStatus.rawValue)
                let vc = HobbyViewController()
                vc.viewModel = self.viewModel
                self.navigationController?.pushViewController(vc, animated: true)
            case DeleteQueueStatusCodeCase.matched.rawValue:
                self.toastMessage(message: "앗! 누군가가 나의 취미 함께 하기를 수락하였어요!")
            default:
                self.toastMessage(message: "오류가 발생했습니다. 잠시 후 다시 시도해주세요.")
            }
        }
    }
    
    //주변새싹 클릭
    @objc func nearUserButtonClicked() {
        mainView.nearUserButton.setTitleColor(.customGreen, for: .normal)
        mainView.nearUserBottomLine.backgroundColor = .customGreen
        
        mainView.requestRecivedButton.setTitleColor(.customGray6, for: .normal)
        mainView.requestRecivedBottomLine.backgroundColor = .customGray6
        
        nowDisplay = !nowDisplay
        checkFindUser()
    }
    
    //주변새싹 클릭시 보여줄 뷰 확인
    func checkFindUser() {
        if findUser != 0 {
            mainView.defaultView.isHidden = true
            mainView.tableView.isHidden = false
            mainView.tableView.reloadData()
            
        } else {
            mainView.defaultView.isHidden = false
            mainView.tableView.isHidden = true
            mainView.defaultView.titleLabel.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
        }
    }
    
    //받은 요청 클릭
    @objc func requestRecivedButtonClicked() {
        mainView.requestRecivedButton.setTitleColor(.customGreen, for: .normal)
        mainView.requestRecivedBottomLine.backgroundColor = .customGreen
        
        mainView.nearUserButton.setTitleColor(.customGray6, for: .normal)
        mainView.nearUserBottomLine.backgroundColor = .customGray6
        
        nowDisplay = !nowDisplay
        checkRequestUser()
    }
    
    //받은요청 클릭시 보여줄 뷰 확인
    func checkRequestUser() {
        if requestUser != 0 {
            mainView.defaultView.isHidden = true
            mainView.tableView.isHidden = false
            mainView.tableView.reloadData()
            
        } else {
            mainView.defaultView.isHidden = false
            mainView.tableView.isHidden = true
            mainView.defaultView.titleLabel.text = "아직 받은 요청이 없어요ㅠ"
        }
    }
}

extension NearUserViewController: CLLocationManagerDelegate{
    func refreshFriends() {
        let form = OnQueueForm(region: viewModel.centerRegion.value, lat: viewModel.centerLatitude.value, long: viewModel.centerLongitude.value)
        viewModel.searchNearFriends(form: form) { onqueueResult, statusCode, error in
            switch statusCode {
            case OnQueueStatusCodeCase.success.rawValue:
                guard let onqueueResult = onqueueResult else {
                    return
                }
                
                for userInfo in onqueueResult.fromQueueDB {
                    self.viewModel.fromNearFriendsHobby.value.append(contentsOf: userInfo.hf)
                    self.viewModel.fromNearFriendsHobby.value = Array(self.viewModel.fromNearFriendsHobby.value)
                }
                
                for userInfo in onqueueResult.fromQueueDBRequested {
                    self.viewModel.fromNearFriendsHobby.value.append(contentsOf: userInfo.hf)
                    self.viewModel.fromNearFriendsHobby.value = Array(Set(self.viewModel.fromNearFriendsHobby.value))
                }
                self.viewModel.fromRecommendHobby.value =  onqueueResult.fromRecommend
                
                switch self.viewModel.searchGender.value {
                case GenderCode.man.rawValue, GenderCode.woman.rawValue:
                    self.viewModel.filteredQueueDB.value = onqueueResult.fromQueueDB.filter({
                        $0.gender == self.viewModel.searchGender.value
                    })
                default:
                    self.viewModel.filteredQueueDB.value = onqueueResult.fromQueueDB
                }
                self.viewModel.filteredQueueDBRequested.value = onqueueResult.fromQueueDBRequested
                
            case OnQueueStatusCodeCase.firebaseTokenError.rawValue:
                self.refreshFirebaseIdToken { idToken, error in
                   if let idToken = idToken {
                       self.refreshFriends()
                   }
               }
            default:
                self.toastMessage(message: "잠시후 다시 시도해주세요.")
            }
        }
        
    }
}

extension NearUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if nowDisplay {
            return findUser
        } else {
            return requestUser
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NearUserViewCell.identifier) as? NearUserViewCell else { return UITableViewCell()}
        
        cell.selectionStyle = .none
        
        if nowDisplay {
            cell.cardImageView.requestButton.backgroundColor = .error
            cell.cardImageView.requestButton.setTitle("요청하기", for: .normal)
        } else {
            cell.cardImageView.requestButton.backgroundColor = .success
            cell.cardImageView.requestButton.setTitle("수락하기", for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
