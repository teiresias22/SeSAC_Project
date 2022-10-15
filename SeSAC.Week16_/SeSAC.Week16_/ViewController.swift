//
//  ViewController.swift
//  SeSAC.Week16_
//
//  Created by Joonhwan Jeon on 2022/01/10.
//

import UIKit

enum GameJob {
    case warrior
    case rpgue
}

class Game {
    var level = 5
    var name = "도사"
    var job: GameJob = .warrior
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cupyOnWrite()
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    //AnyObject vs Any
    //런타임 시점에 타입이 결정, -> 런타임 오류
    //컴파일 시점에서 알 수 없음
    //Any: Class, Struct, Enum, Closure..
    //AnyObject: Class
    func aboutAnyObject() {
        let name = "고래밥"
        let gender = false
        let age = 10
        let characters = Game()
        
        let anylist: [Any] = [name, gender, age]
        print(anylist)
        let anyobject: [AnyObject] = [characters]
        if let value = anylist[0] as? String {
            print(value)
        }
    }
    
    func cupyOnWrite() {
        var nickname = "jack"
        
        var nicknameByFamily = nickname
        
        nicknameByFamily = "꽁"
        
        print(nickname, nicknameByFamily)
    }


}

