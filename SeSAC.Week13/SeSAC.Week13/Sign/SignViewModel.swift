//
//  SignViewModel.swift
//  SeSAC.Week13
//
//  Created by Joonhwan Jeon on 2022/01/08.
//

import Foundation
import UIKit

class SignViewModel {
    
    var navigationTitle: String = "네비게이션 타이틀"
    var buttonTitle: String = "가입하기"
    
    func didTapButton(completion: @escaping () -> Void) {
        completion()
    }
    
    var text: String = "" {
        didSet {
            let count = text.count
            let value = count >= 100 ? "작성할 수 없습니다." : "\(count)/100"
            let color: UIColor = count >= 100 ? .red : .black
            
            listener?(value, color)
        }
    }
    
    var listener: ((String, UIColor) -> Void)?
    
    func bind(listener: @escaping (String, UIColor) -> Void) {
        self.listener = listener
    }
}
