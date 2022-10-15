import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var urlSearchBar: UISearchBar!
    
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlSearchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
}

extension WebViewController: UISearchBarDelegate{
    
    //서치바에서 검색 리턴키 클릭
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let url = URL(string: searchBar.text ?? "") else {
            print("ERROR")
            return
        }
        
        let requeset = URLRequest(url: url)
        webView.load(requeset)
    }
    
}
