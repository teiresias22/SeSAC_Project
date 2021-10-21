import UIKit

class WebViewController: UIViewController {

    var tvShow: TvShow?
    let tvInformation = tvShowInformation()
    
    @IBOutlet weak var mediaPosterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = tvShow?.title ?? "Title"
        mediaPosterImage.image = UIImage(named: tvShow?.title ?? "")
        
    }
    


}
