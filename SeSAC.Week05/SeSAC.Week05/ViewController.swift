//
//  ViewController.swift
//  SeSAC.Week05
//
//  Created by Joonhwan Jeon on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWindLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getCurrentWather()
    }
    
    func getCurrentWather() {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=f7f4b5e20e84f16de898ecd64e188ef3"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let currentTemp = json["main"]["temp"].doubleValue - 273.15
                self.currentTempLabel.text = "\(Int(currentTemp))C"
                print(currentTemp)
                
                let currentWind = json["wind"]["speed"].doubleValue
                self.currentWindLabel.text = "풍속\(Int(currentWind))m/s"
                
                
                
            case .failure(let error):
                print(error)
            }
        }
    }


}

