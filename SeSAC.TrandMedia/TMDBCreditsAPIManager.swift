import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class TMDBCreditsAPIManager {
    
    static let shared = TMDBCreditsAPIManager()
    
    typealias CompletionHandler = (JSON) -> ()
    
    func fetchTranslateData(mediaType: String, mediaID: Int, result: @escaping CompletionHandler ) {
        
        let url = Endpoint.TMDBCredits + "\(mediaType)/\(mediaID)/credits?api_key=\(APIkey.TMDB_ID)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                result(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
