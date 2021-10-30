import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    typealias CompletionHandler = (JSON) -> ()
    
    func fetchTranslateData(page: Int, mediaType: String, timeWindow: String, result: @escaping CompletionHandler) {
        
        let url = Endpoint.TMDBTranding + "\(mediaType)/\(timeWindow)?api_key=\(APIkey.TMDB_ID)" + "&query=&page=\(page)"
        
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
