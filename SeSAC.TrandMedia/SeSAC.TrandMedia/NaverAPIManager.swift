import UIKit
import Alamofire
import SwiftyJSON

class NaverAPIManager {
    
    static let shared = NaverAPIManager()
    
    typealias CompletionHandler = (JSON) -> ()
    
    func fetchMovieData(serviceType: String, query: String, startPage: Int, result: @escaping CompletionHandler) {
        
        if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = Endpoint.NaverSearch + "\(serviceType).json?query=\(query)&display=20&start=\(startPage)"
            
            let header: HTTPHeaders = [
                "X-Naver-Client-Id": APIkey.Naver_ID,
                "X-Naver-Client-Secret": APIkey.Naver_Secret
            ]
            
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
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
}
