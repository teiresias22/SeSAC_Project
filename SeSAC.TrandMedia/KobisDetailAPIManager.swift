//
//  KobisDetailAPIManager.swift
//  SeSAC.TrandMedia
//
//  Created by Joonhwan Jeon on 2022/03/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class KobisDetailAPIManager {
    static let shared = KobisDetailAPIManager()
    
    typealias CompletionHandler = (JSON) -> ()
    
    func fetchTranslateData(movieID: String, result: @escaping CompletionHandler) {
        let url = Endpoint.KobisDetailURL + movieID
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                result(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
