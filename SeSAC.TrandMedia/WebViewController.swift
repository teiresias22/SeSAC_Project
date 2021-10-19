import UIKit

class WebViewController: UIViewController {

    var tvShow: TvShow?
    let tvInformation = tvShowInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = tvShow?.title ?? "Title"
        
    }
    


}
