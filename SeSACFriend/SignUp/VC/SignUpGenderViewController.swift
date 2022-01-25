//
//  SignUpGenderViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/21.
//

import UIKit

class SignUpGenderViewController: BaseViewController {
    let mainView = SignUpGenderView()
    let validation = Validation()
    
    var manButton = false
    var womanButton = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.genderManView.tag = 100
        mainView.genderWomanView.tag = 200
        
        self.mainView.genderManView.isUserInteractionEnabled = true
        self.mainView.genderWomanView.isUserInteractionEnabled = true
        
        self.mainView.genderManView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewClicked)))
        self.mainView.genderWomanView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewClicked)))
        
        mainView.submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
    }
    
    @objc func viewClicked(_ sender: UITapGestureRecognizer) {
        if sender.view!.tag == 100 {
            manButton = !manButton
            if manButton {
                mainView.genderManView.backgroundColor = .customWhiteGreen
                mainView.genderWomanView.backgroundColor = .customWhite
                womanButton = false
            } else {
                mainView.genderManView.backgroundColor = .customWhite
            }
        } else if sender.view!.tag == 200 {
            womanButton = !womanButton
            if womanButton {
                mainView.genderWomanView.backgroundColor = .customWhiteGreen
                mainView.genderManView.backgroundColor = .customWhite
                manButton = false
            } else {
                mainView.genderWomanView.backgroundColor = .customWhite
            }
        }
        submitButtonActiveCheck()
    }
    
    @objc func submitButtonClicked(_ sender: Any) {
        /*
        서버통신시 Int 전달, 남자: 1 여자: 2 미선택: -1
        이후 사용자 정보 서버에 전송 : (post, /user)
        성공 응답 → 홈 화면 전환
        금지된 단어로 닉네임 사용한 경우(code 202) → 닉네임 입력 화면으로 전환
        사용자 기입 내용 유지
        Firebase Token 만료(code 401) → Token 갱신 후 재요청
        세부사항은 API 명세서 참고
         */
    }
    
    func submitButtonActiveCheck() {
        if manButton || womanButton {
            mainView.submitButton.backgroundColor = .customGreen
        } else {
            mainView.submitButton.backgroundColor = .customGray7
        }
    }
}
