//
//  ChattingViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/12.
//

import UIKit
import Alamofire

class ChattingViewController: BaseViewController {
    let mainView = ChattingView()
    var viewModel: HomeViewModel!
    var chatViewModel: ChatViewModel!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        SocketIOManager.shared.establishConnection()
        
        viewModel.checkMyQueueStatus { MyQueueStateResult, statuscode, error in
            guard let MyQueueStateResult = MyQueueStateResult else {
                return
            }
            
            self.title = MyQueueStateResult.matchedNick
            
            if MyQueueStateResult.matched == 1 {
                UserDefaults.standard.set(MyQueueStatusCodeCase.RawValue(), forKey: UserDefault.myStatus.rawValue)
            }
            
            UserDefaults.standard.set(MyQueueStateResult.matchedUid, forKey: UserDefault.otherUid.rawValue)
        }
        chatViewModel.chatList.bind { _ in
            self.mainView.mainTableView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SocketIOManager.shared.closeConnection()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "ellipsis.vertical"), style: .done, target: self, action: #selector(onMoreButtonClicked))
        moreButton.tintColor = .customBlack
        self.navigationItem.rightBarButtonItem = moreButton
        
        mainView.chatView.textView.delegate = self
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        mainView.mainTableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        mainView.mainTableView.register(OtherChatTableViewCell.self, forCellReuseIdentifier: OtherChatTableViewCell.identifier)
        mainView.mainTableView.register(ChattingHeaderTableViewCell.self, forCellReuseIdentifier: ChattingHeaderTableViewCell.identifier)
        
        mainView.mainTableView.estimatedRowHeight = UITableView.automaticDimension
        mainView.mainTableView.separatorStyle = .none
        mainView.mainTableView.keyboardDismissMode = .onDrag
        
        mainView.menuView.reportButton.addTarget(self, action: #selector(reportButtonClicked), for: .touchUpInside)
        mainView.menuView.dodgeButton.addTarget(self, action: #selector(dodgeButtonClicked), for: .touchUpInside)
        mainView.menuView.rateButton.addTarget(self, action: #selector(rateButtonClicked), for: .touchUpInside)
        
        // MARK: 채팅
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(noti:)), name: NSNotification.Name("getMessage"), object: nil)
        
        mainView.chatView.sendMessageButton.addTarget(self, action: #selector(sendMessageButtonClicked), for: .touchUpInside)
        
        requestChats()
        
        print("otherUid: ",UserDefaults.standard.string(forKey: UserDefault.otherUid.rawValue)!)
    }
    
    func requestChats() {
        print(#function)

        chatViewModel.recieveMessage(lastchatDate: self.chatViewModel.tmpLastChatDate,from: UserDefaults.standard.string(forKey: UserDefault.otherUid.rawValue)! ) { chats, statuscode in
            print("requestChats",statuscode)
            
            switch statuscode {
            case ChatStatusCodeCase.success.rawValue:
                guard let chats = chats else {
                    return
                }
                print(chats)
                
                self.mainView.mainTableView.reloadData()
                
                if self.chatViewModel.chatList.value.count > 0 {
                    self.mainView.mainTableView.scrollToRow(at: IndexPath(row: self.chatViewModel.chatList.value.count-1, section: 1), at: .bottom, animated: false)
                }
                
            default:
                self.toastMessage(message: "채팅 내역을 불러오는데 실패했습니다.")
            }
        }
    }
    
    func postChat(chat: String) {
        chatViewModel.sendMessage(chat: chat, to: UserDefaults.standard.string(forKey: UserDefault.otherUid.rawValue)!) { chat, statuscode in

            switch statuscode {
            case ChatStatusCodeCase.success.rawValue:
                print("success")
                // 보내고 -> 다시 데이터 불러오기
                self.requestChats()
            case ChatStatusCodeCase.fail.rawValue:
                self.toastMessage(message: "매칭이 해제된 상태입니다.")
            default:
                self.toastMessage(message: "메세지 전송에 실패했습니다.")
            }
        }
    }
    
    @objc func getMessage(noti: NSNotification) {
        print(#function)
        
        let from = noti.userInfo!["from"] as! String
        let to = noti.userInfo!["to"] as! String
        let chat = noti.userInfo!["chat"] as! String
        let id = noti.userInfo!["_id"] as! String
        let createdAt = noti.userInfo!["createdAt"] as! String
        let v = noti.userInfo!["__v"] as! Int
        
        // 뷰모델에 추가
        let value = Chat(from: from, to: to, chat: chat, id: id, createdAt: createdAt, v: v)
        
        self.chatViewModel.chatList.value.append(value)

        self.mainView.mainTableView.reloadData()
        if self.chatViewModel.chatList.value.count > 0 {
            self.mainView.mainTableView.scrollToRow(at: IndexPath(row: self.chatViewModel.chatList.value.count-1, section: 1), at: .bottom, animated: false)
        }
    }
    
    @objc func onMoreButtonClicked() {
        mainView.moreView.isHidden.toggle()
        view.endEditing(true)
    }
    
    @objc func reportButtonClicked() {
        mainView.moreView.isHidden.toggle()
        
        let vc = HomeChattingReportViewController()
        vc.modalTransitionStyle = . crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
        
    }
    
    @objc func dodgeButtonClicked() {
        mainView.moreView.isHidden.toggle()
        
        let vc = HomeChattingDodgeViewController()
        vc.modalTransitionStyle = . crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @objc func rateButtonClicked() {
        mainView.moreView.isHidden.toggle()
        
        let vc = HomeChattingRateViewController()
        vc.modalTransitionStyle = . crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
        
    }
    
    @objc func sendMessageButtonClicked() {
        // 가능할때만 (빈 채팅 or placeholder 안보내기)
        if mainView.chatView.sendMessageButton.image(for: .normal) == UIImage(named: "sendButton_fill") {
            postChat(chat: chatView.textView.text)
            mainView.chatView.sendMessageButton.setImage(UIImage(named: "sendButton"), for: .normal)
            mainView.chatView.textView.text = ""
            view.endEditing(true)
            requestChats()
        }
    }
}
 
extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    
}

extension ChattingViewController: UITextViewDelegate {
    
}
