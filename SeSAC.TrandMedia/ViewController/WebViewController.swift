import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class WebViewController: UIViewController{
    @IBOutlet weak var mediaWebView: WKWebView!
    
    static let identifier = "WebViewController"
    
    var mediaData: MediaModel?
    var mediaURL: String = "" {
        didSet {
            loadWebView()
        }
    }
    var mediaID: String?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mediaData!.mediaType == "movie" {
            title = mediaData!.originalTitle
        } else {
            title = mediaData!.originalName
        }
        
        fetcMediaData()
        print(mediaData!.mediaType)
        print(mediaData!.id)
    }
    func fetcMediaData() {
        TMDBTypeAPIManager.shared.fetchTranslateData(mediaType: mediaData!.mediaType, mediaID: mediaData!.id, APIType: "videos") { json in
            self.mediaURL = json["results"][0]["key"].stringValue
            print("url\(self.mediaURL)")
        }
    }
    
    func loadWebView() {
        let mediaUrl = "https://www.youtube.com/watch?v=" + mediaURL
        let url = URL(string: mediaUrl)
        let request = URLRequest(url: url!)
        mediaWebView.load(request)
    }
}
