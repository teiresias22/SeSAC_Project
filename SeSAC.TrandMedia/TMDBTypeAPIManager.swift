import UIKit
import Alamofire
import SwiftyJSON

class TMDBTypeAPIManager {
    
    static let shared = TMDBTypeAPIManager()
    
    typealias CompletionHandler = (JSON) -> ()
    
    func fetchTranslateData(mediaType: String, mediaID: Int, APIType: String, startPage: Int, result: @escaping CompletionHandler ) {

        let url = Endpoint.TMDBType + "\(mediaType)/\(mediaID)/\(APIType)?api_key=\(APIkey.TMDB_ID)&language=ko-KR&page=\(startPage)"
        
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
