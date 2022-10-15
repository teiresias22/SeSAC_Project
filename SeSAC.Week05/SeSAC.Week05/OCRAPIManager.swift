import Alamofire
import SwiftyJSON
import UIKit.UIImage

class OCRAPIManager {
    
    static let shared = OCRAPIManager()
    
    func fetchOCRData(image: UIImage, result: @escaping (Int, JSON) -> () ) {
        
        let header: HTTPHeaders = [
            "Authorization": APIkey.KAKAO,
            "Content-Type": "multipart/form-data"
        ]
        
        guard let imageData = image.pngData() else { return }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image")
        }, to: Endpoint.OCRURL, headers: header).validate(statusCode: 200...500).responseJSON { response in
                
            switch response.result {
            case .success(let value):
                    
            let json = JSON(value)
            print("JSON: \(json)")
                    
            let code = response.response?.statusCode ?? 500
                    
            result(code, json)
                   
            case .failure(let error):
            print(error)
            }
        }
        
    }
    
    
}
