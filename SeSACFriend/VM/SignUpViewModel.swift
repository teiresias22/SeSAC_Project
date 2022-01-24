//
//  SignUpViewModel.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/17.
//

import UIKit

class SignUpViewModel {
    var phoneNumber: Observable<String> = Observable("")
    
}

class SignUpCodeCheckViewModel{
    var varificationCode: Observable<String> = Observable("")
    
}

class SignUpNickNameViewModel{
    var nickName: Observable<String> = Observable("")
    
}

class SignUpEmailViewModel{
    var email: Observable<String> = Observable("")
    
}
