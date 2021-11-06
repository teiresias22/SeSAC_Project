import UIKit
import Alamofire
import SwiftyJSON

class KobisAPIManager {
    
    static let shared = KobisAPIManager()
    
    typealias CompletionHandler = (JSON) -> ()
    
    func fetchBoxofficeData(nowDate: String, result: @escaping CompletionHandler) {
        
        let url = Endpoint.KobisURL + nowDate
        
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
