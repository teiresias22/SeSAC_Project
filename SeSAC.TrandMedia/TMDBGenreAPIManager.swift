import UIKit
import Alamofire
import SwiftyJSON

class TMDBGenreAPIManager {
    
    static let shared = TMDBGenreAPIManager()
    
    typealias CompletionHandler = (JSON) -> ()
    
    func fetchTranslateData(mediaType: String, result: @escaping CompletionHandler ) {

        let url = Endpoint.TMDBType + "genre/\(mediaType)/list?api_key=\(APIkey.TMDB_ID)&language=ko-KR"
        
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
