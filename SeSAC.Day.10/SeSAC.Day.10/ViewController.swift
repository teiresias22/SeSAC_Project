//
//  ViewController.swift
//  SeSAC.Day.10
//
//  Created by Joonhwan Jeon on 2021/10/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputKRW: UITextField!
    @IBOutlet weak var inputExchangeRate: UITextField!
    
    @IBOutlet weak var lbKRW: UILabel!
    @IBOutlet weak var lbExchangeRate: UILabel!
    
    @IBOutlet weak var btnCalculate: UIButton!
    @IBOutlet weak var lbResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        defaultSetting()
        process()
        
    }
    
    func defaultSetting() {
        inputKRW.placeholder = "환전할 금액을 입력하세요"
        lbKRW.text = "/원 KRW"
        
        inputExchangeRate.placeholder = "1192"
        lbExchangeRate.text = "원달러"
        
        btnCalculate.titleLabel?.text = "계산하기"
        lbResult.text = "결과"
    }
    
    struct exchangeRate {
        var currencyRate : Double {
            willSet {
                print("환율이 변동될 예정 입니다. \(currencyRate) > \(newValue)")
            }
            didSet {
                print("환율이 변동되었습니다. \(oldValue) > \(currencyRate)")
            }
        }
        var USD: Double {
            get {
                let prosessingExchange = KRW / currencyRate
                return prosessingExchange
            }
        }
        var KRW: Double
    }
    func process(){
        var exchange = exchangeRate(currencyRate: 1192.0, KRW: 500000.0)
        print(exchange)
    }
    
    
}

