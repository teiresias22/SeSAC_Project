//
//  MyDetailViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/29.
//

import UIKit
import FirebaseAuth
import SnapKit

class MyDetailViewController: BaseViewController {
    let mainView = MyDetailView()
    var viewModel: MyViewModel!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "정보관리"
        
        
    }
    
    //1. 메인뷰 안에 있는 커스텀뷰의 높이를 조절, 애니메이션 효과를 주고, 뷰를 다시 로드 한다.
    //      메인뷰 안의 커스텀스텀뷰의 높이 조절은 가능하나, 뷰를 다시 로드하는 방식을 찾을수가 없다.
    //2. 컨테이너뷰를 제작해서 높이를 조절한다
    //      컨테이너뷰는 코드로 제작이 안되는듯??
    //      Xib파일로도 컨테이너뷰는 제작이 안되네??
    //3. 테이블뷰로 제작한다
    
    @objc func toggleButtonClicked() {
        print("Toggle Clicked1", mainView.customUserInfoView.snp.height)
        DispatchQueue.main.async {
            self.mainView.customUserInfoView.snp.updateConstraints { make in
                make.height.equalTo(800)
            }
        }
        print("Toggle Clicked2", mainView.customUserInfoView.snp.height)
    }
    
    
    
    
}
