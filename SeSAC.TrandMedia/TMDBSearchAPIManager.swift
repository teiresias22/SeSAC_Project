import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class TMDBSearchAPIManager {
    
    static let shared = TMDBSearchAPIManager()
    
    typealias CompletionHandler = (JSON) -> ()
    
    func fetchTranslateData(mediaType: String, text: String, startPage: Int, result: @escaping CompletionHandler ) {

        let url = Endpoint.TMDBType + "search/\(mediaType)?query=\(text)&api_key=\(APIkey.TMDB_ID)&page=\(startPage)"
        
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
