import UIKit
import Alamofire
import SwiftyJSON

class LotteryViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var drowcountEnter: UITextField!
    @IBOutlet weak var drowDateLabel: UILabel!
    @IBOutlet weak var drowCountLabel: UILabel!
    
    @IBOutlet weak var drowNumberLabel01: UILabel!
    @IBOutlet weak var drowNumberLabel02: UILabel!
    @IBOutlet weak var drowNumberLabel03: UILabel!
    @IBOutlet weak var drowNumberLabel04: UILabel!
    @IBOutlet weak var drowNumberLabel05: UILabel!
    @IBOutlet weak var drowNumberLabel06: UILabel!
    @IBOutlet weak var drowNumberLabelBonus: UILabel!
    
    @IBOutlet weak var drowNumberBoll01: UIView!
    @IBOutlet weak var drowNumberBoll02: UIView!
    @IBOutlet weak var drowNumberBoll03: UIView!
    @IBOutlet weak var drowNumberBoll04: UIView!
    @IBOutlet weak var drowNumberBoll05: UIView!
    @IBOutlet weak var drowNumberBoll06: UIView!
    @IBOutlet weak var drowNumberBoll07: UIView!
    
    var drowCountArray = Array(1...986)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drowCountArray.sort(by: >)

        drowcountEnter.text = "986"
        defaultSetting()
        getDrowNumber("986")
        
        drowcountEnter.tintColor = .clear
        createPickerView()
        dismissPickerView()
        // Do any additional setup after loading the view.
    }
    
    func defaultSetting(){
        drowCountLabel.textColor = .orange
        
        drowNumberLabel01.textColor = .white
        drowNumberLabel01.textAlignment = .center
        drowNumberLabel02.textColor = .white
        drowNumberLabel02.textAlignment = .center
        drowNumberLabel03.textColor = .white
        drowNumberLabel03.textAlignment = .center
        drowNumberLabel04.textColor = .white
        drowNumberLabel04.textAlignment = .center
        drowNumberLabel05.textColor = .white
        drowNumberLabel05.textAlignment = .center
        drowNumberLabel06.textColor = .white
        drowNumberLabel06.textAlignment = .center
        drowNumberLabelBonus.textColor = .white
        drowNumberLabelBonus.textAlignment = .center
        
        drowNumberBoll01.contentMode = .scaleToFill
        drowNumberBoll01.layer.cornerRadius = drowNumberBoll01.frame.height/2
        drowNumberBoll01.clipsToBounds = true
        drowNumberBoll01.backgroundColor = .systemCyan
        
        drowNumberBoll02.contentMode = .scaleToFill
        drowNumberBoll02.layer.cornerRadius = drowNumberBoll01.frame.height/2
        drowNumberBoll02.clipsToBounds = true
        drowNumberBoll02.backgroundColor = .systemCyan
        
        drowNumberBoll03.contentMode = .scaleToFill
        drowNumberBoll03.layer.cornerRadius = drowNumberBoll01.frame.height/2
        drowNumberBoll03.clipsToBounds = true
        drowNumberBoll03.backgroundColor = .systemBlue
        
        drowNumberBoll04.contentMode = .scaleToFill
        drowNumberBoll04.layer.cornerRadius = drowNumberBoll01.frame.height/2
        drowNumberBoll04.clipsToBounds = true
        drowNumberBoll04.backgroundColor = .systemBlue
        
        drowNumberBoll05.contentMode = .scaleToFill
        drowNumberBoll05.layer.cornerRadius = drowNumberBoll01.frame.height/2
        drowNumberBoll05.clipsToBounds = true
        drowNumberBoll05.backgroundColor = .systemPink
        
        drowNumberBoll06.contentMode = .scaleToFill
        drowNumberBoll06.layer.cornerRadius = drowNumberBoll01.frame.height/2
        drowNumberBoll06.clipsToBounds = true
        drowNumberBoll06.backgroundColor = .systemPink
        
        drowNumberBoll07.contentMode = .scaleToFill
        drowNumberBoll07.layer.cornerRadius = drowNumberBoll01.frame.height/2
        drowNumberBoll07.clipsToBounds = true
        drowNumberBoll07.backgroundColor = .systemMint
        
    }
    
    func getDrowNumber(_ number: String) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=" + number
        print(url)
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let drwNo = json["drwNo"].stringValue
                self.drowCountLabel.text = drwNo + "회"
                
                let drwNoDate = json["drwNoDate"].string
                self.drowDateLabel.text = drwNoDate
                self.drowDateLabel.textColor = .systemGray
                
                
                let drwtNo1 = json["drwtNo1"].stringValue
                self.drowNumberLabel01.text = drwtNo1
                
                let drwtNo2 = json["drwtNo2"].stringValue
                self.drowNumberLabel02.text = drwtNo2
                
                let drwtNo3 = json["drwtNo3"].stringValue
                self.drowNumberLabel03.text = drwtNo3
                
                let drwtNo4 = json["drwtNo4"].stringValue
                self.drowNumberLabel04.text = drwtNo4
                
                let drwtNo5 = json["drwtNo5"].stringValue
                self.drowNumberLabel05.text = drwtNo5
                
                let drwtNo6 = json["drwtNo6"].stringValue
                self.drowNumberLabel06.text = drwtNo6
                
                let bnusNo = json["bnusNo"].stringValue
                self.drowNumberLabelBonus.text = bnusNo
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return drowCountArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(drowCountArray[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        drowcountEnter.text = String(drowCountArray[row])
        return getDrowNumber(String(drowCountArray[row]))
        
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        drowcountEnter.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let Button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(getter: self.drowcountEnter))
        toolBar.setItems([Button], animated: true)
        toolBar.isUserInteractionEnabled = true
        drowcountEnter.inputAccessoryView = toolBar
    }
    
    
}
