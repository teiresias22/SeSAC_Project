//
//  APIService.swift
//  SeSAC.Week13
//
//  Created by Joonhwan Jeon on 2022/01/06.
//

import Foundation

enum APIError: String, Error {
    case unknownError = "alert_error_unknown"
    case serverError = "alert_error_server"
}

extension APIError: LocalizedError {
    var errorDescription: String?{
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

class APIService {
    
    let sourceURL = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleList.json?key=f5eef3421c602c6cb7ea224104795888")!
    
    func requestCast(completion: @escaping (Cast?) -> Void) {
        URLSession.shared.dataTask(with: sourceURL) { data, response, error in
            print(data)
            print(response)
            print(error)
            
            if let error = error {
                self.showAlert(.unknownError)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                self.showAlert(.serverError)
                return
            }

            if let data = data, let castData = try? JSONDecoder().decode(Cast.self, from: data) {
                print("SUCCEED", castData)
                completion(castData)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func showAlert(_ msg: APIError) {
        //Alert 구현
    }
}
