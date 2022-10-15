
import UIKit

class Search_ViewController: UIViewController {
    
    
    @IBOutlet var tfSearchBar: UITextField!
    @IBOutlet var btnSearchButton: UIButton!
    
    @IBOutlet var btnTagFirstButton: UIButton!
    @IBOutlet var btnTagSecondButton: UIButton!
    @IBOutlet var btnTagThirdButton: UIButton!
    @IBOutlet var btnTagFourthButton: UIButton!
    
    @IBOutlet var lbSearchResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagButtonRecomend(btnTagFirstButton, "TagFirst")
        tagButtonRecomend(btnTagSecondButton, "TagSecond")
        tagButtonRecomend(btnTagThirdButton, "TagThird")
        tagButtonRecomend(btnTagFourthButton, "TagFourth")
        
        searchButton(btnSearchButton)

        // Do any additional setup after loading the view.
    }
    func tagButtonRecomend (_ btn: UIButton, _ title: String) {
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 12
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
    }
    
    func searchButton (_ btn: UIButton) {
        btn.backgroundColor = .black
    }
    
    var newWordDictionary: [String:String] = ["만반잘부":"만나서 반가워 잘 부탁해", "머선129":"무슨 일이고?", "내또출":"내일 또 출근", "이생집말":"이번 생에 집사기는 망했다", "스불재":"스스로 불러온 재앙", "킹받네":"킹+열받네", "롬곡":"눈물", "스라벨":"공부와 삶의 균형"]
    var newWord = ["만반잘부", "머선129", "내또출", "이생집망", "스불재", "킹받네", "롬곡", "스라벨"]
    var randomNumber = Int.random(in: 0...7)
    
    @IBAction func btnSearch(_ sender: UIButton) {
        var keyWord = tfSearchBar.text
        
        if keyWord == "" {
            lbSearchResult.text = "검색어를 입력해주세요."
        }else if keyWord == "만반잘부"{
            lbSearchResult.text = "만나서 반가워 잘 부탁해"
        }else if keyWord == "머선129"{
            lbSearchResult.text = "무슨 일이고?"
        }else if keyWord == "내또출"{
            lbSearchResult.text = "내일 또 출근"
        }else if keyWord == "이생집망"{
            lbSearchResult.text = "이번 생애 집사기는 망했다."
        }else if keyWord == "스불재"{
            lbSearchResult.text = "스스로 불러온 재앙"
        }else if keyWord == "킹받네"{
            lbSearchResult.text = "킹 + 열받네"
        }else if keyWord == "롬곡"{
            lbSearchResult.text = "눈물"
        }else if keyWord == "스라벨"{
            lbSearchResult.text = "공부와 삶의 균형"
        }else {
            lbSearchResult.text = "검색어를 확인할 수 없습니다."
        }
    }
    
    @IBAction func btnTagButton(_ sender: Any) {
    }
    


}
