//
//  RandomViewController.swift
//  SSAC.Baemin
//
//  Created by Joonhwan Jeon on 2021/09/29.
//

import UIKit

class RandomViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var checkButton: UIButton!
    
    //뷰컨트롤러 생명주기
    //화면이 사용자에게 보이기 직전에 실행하는 기능 : 모서리 둥글게, 그림자 속성 등 스토리보드에 구현하기 까다로운 UI를 미리 구현할 떄 주로 사용
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "안녕하세요\n반갑습니다"
        resultLabel.textAlignment = .center
        resultLabel.backgroundColor = .systemRed
        resultLabel.numberOfLines = 2
        resultLabel.font = UIFont.boldSystemFont(ofSize: 20)
        resultLabel.textColor = .white
        resultLabel.layer.cornerRadius = 10
        resultLabel.clipsToBounds = true
        
        checkButton.backgroundColor = UIColor.magenta
        checkButton.setTitle("행운의 숫자를 뽑아보세요", for: .normal)
        checkButton.setTitle("뽑아 뽑아", for: .highlighted)
        checkButton.layer.cornerRadius = 10
        checkButton.setTitleColor(.white, for: .normal)
    }

    @IBAction func checkButtonClicked(_ sender: UIButton) {
        let randomNumber = Int.random(in: 1...100)
        resultLabel.text = "행운의 숫자는 \(randomNumber)입니다."
    }
}
