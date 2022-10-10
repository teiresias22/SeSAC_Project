

import UIKit

class ViewController: UIViewController {
    
    //Top Set
    @IBOutlet var whelcomeTextLabel: UILabel!
    @IBOutlet var nowDrinkWater: UILabel!
    @IBOutlet var nowDrinkWaterPercent: UILabel!
    
    //Center Set
    @IBOutlet var drinkWaterImageChange: UIImageView!
    @IBOutlet var nowDrinkingWater: UITextField!
    
    //Buttom Set
    @IBOutlet var userInfomationNotice: UILabel!
    @IBOutlet var drinkWaterSave: UIButton!
    
    //바탕 색상 설정
    let customGreen: UIColor = UIColor(red: 65/255, green: 148/255, blue: 144/255, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = customGreen
        
        whelcomeTextLabel.numberOfLines = 2
        whelcomeTextLabel.text = "잘하고 있어요!\n오늘 마신 양은"
        whelcomeTextLabel.font = .systemFont(ofSize: 20)
        whelcomeTextLabel.textColor = .white
        
        updateDrinkWater(nowDrinkWater, "water")
        nowDrinkWater.font = .boldSystemFont(ofSize: 24)
        nowDrinkWater.contentMode = .center
        nowDrinkWater.textColor = .white
        
        nowDrinkWaterPercent.font = .systemFont(ofSize: 12)
        nowDrinkWaterPercent.textColor = .white
        
        userInfomationNotice.font = .systemFont(ofSize: 12)
        userInfomationNotice.textAlignment = .center
        userInfomationNotice.textColor = .white
        
        ImageChange()
        
        nowDrinkingWater.placeholder = "ml"
        
        drinkWaterSave.setTitle("물마시기", for: .normal)
        drinkWaterSave.setTitleColor(customGreen, for: .normal)
        drinkWaterSave.backgroundColor = .white
    }
    
    //페이지가 전환시 무조건 실행
    override func viewWillAppear(_ animated: Bool) {
        //실행 전 부모 클래스의 메서드 부터 실행 **
        super.viewWillAppear(animated)
        userName()
        PercentWater()
        viewWillAppearLoardRecordDate("NowDate")
        compareTwoRecordDate()
    }
    
    //텝키로 키보드 숨기기
    @IBAction func tapGestureKeyboardHide(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    //BarButton의 리셋버튼
    @IBAction func btnDrinkWaterReset(_ sender: UIBarButtonItem) {
        UserDefaults.standard.removeObject(forKey: "NickName")
        UserDefaults.standard.removeObject(forKey: "Hight")
        UserDefaults.standard.removeObject(forKey: "Weight")
        UserDefaults.standard.removeObject(forKey: "PercentWater")
        UserDefaults.standard.removeObject(forKey: "water")
        UserDefaults.standard.removeObject(forKey: "Profile")
        UserDefaults.standard.removeObject(forKey: "number")
        UserDefaults.standard.removeObject(forKey: "ImgNum")
        PercentWater()
        ImageChange()
        userName()
        updateDrinkWater(nowDrinkWater, "water")
    }
    
    //하단의 마시기 버튼 클릭시,
    @IBAction func btnNowDrinkWaterSave(_ sender: UIButton) {
        drinkWaterButtonClickedRecordDate("RecordDate")
        compareTwoRecordDate()
        PercentWater()
        ImageChange()
        nowDrinkingWater.text = ""
    }
    
    //이름을 입력하지 않았을때 기본값 설정하기
    func userName() {
        let goralWater = (Double(UserDefaults.standard.string(forKey: "Weight") ?? "") ?? 0.0) * 0.03
        
        let defaultName = "이름"
        let name = String(UserDefaults.standard.string(forKey: "NickName") ?? "")
        if name == "" {
            userInfomationNotice.text = "\(defaultName) 님의 하루 물 권장 섭취량은 \(String(format: "%.1f", goralWater))L 입니다."
        } else {
            userInfomationNotice.text = "\(name) 님의 하루 물 권장 섭취량은 \(String(format: "%.1f", goralWater))L 입니다."
        }
    }
    
    //목표값의 % 구하기, 소수점 첫번째 자리까지 표시
    func PercentWater() {
        let goralWater = (Double(UserDefaults.standard.string(forKey: "Weight") ?? "") ?? 0.0) * 0.03
        
        let water = Double(UserDefaults.standard.integer(forKey: "water"))
        let percentWater = (water / (goralWater * 1000)) * 100
        UserDefaults.standard.set(percentWater, forKey: "PercentWater")
        let updatePercentWater = UserDefaults.standard.double(forKey: "PercentWater")
        if goralWater > 0 {
            nowDrinkWaterPercent.text = "목표의 " + String(format: "%.1f", updatePercentWater) + "%"
        } else {
            nowDrinkWaterPercent.text = "목표의 0.0%"
        }
    }
    
    //메인이미지 변경 함수, 몸무계가 입력되어 있다면 퍼센트에 따라 변경되고, 그렇지 않다면 기본 이미지만 출력
    func ImageChange() {
        let water = Int(UserDefaults.standard.integer(forKey: "PercentWater"))
        let weight = Int(UserDefaults.standard.integer(forKey: "Weight"))
        
        if weight > 0 {
            if water < 11{
                drinkWaterImageChange.image = UIImage.init(named: "1-1")
            } else if water < 22{
                drinkWaterImageChange.image = UIImage.init(named: "1-2")
            } else if water < 33{
                drinkWaterImageChange.image = UIImage.init(named: "1-3")
            } else if water < 44{
                drinkWaterImageChange.image = UIImage.init(named: "1-4")
            } else if water < 55{
                drinkWaterImageChange.image = UIImage.init(named: "1-5")
            } else if water < 66{
                drinkWaterImageChange.image = UIImage.init(named: "1-6")
            } else if water < 77{
                drinkWaterImageChange.image = UIImage.init(named: "1-7")
            } else if water < 88{
                drinkWaterImageChange.image = UIImage.init(named: "1-8")
            } else {
                drinkWaterImageChange.image = UIImage.init(named: "1-9")
            }
        } else {
            drinkWaterImageChange.image = UIImage.init(named: "1-1")
        }
    }
    
    //상단 라벨에 현재 마신 물의 총량을 출력, - 값으로 간다면 0으로 변환
    func updateDrinkWater( _ l: UILabel, _ t: String){
        let dringkWater = UserDefaults.standard.integer(forKey: t)
        if Int(dringkWater) < 0 {
            UserDefaults.standard.set(0, forKey: t)
            l.text = "0 ml"
        }else {
            l.text = "\(dringkWater) ml"
        }
    }
    
    // 마신 양을 합산하여 출력, - 값이 나온다면 0으로 변환
    func DrinkButtonClicked( _ l: UILabel,  _ target: String ) {
        let nowDrink = Int(nowDrinkingWater.text!) ?? 0
        let drinkWater = UserDefaults.standard.integer(forKey: target)
        UserDefaults.standard.set(drinkWater+nowDrink, forKey: target)
        let updateDrinkWater = UserDefaults.standard.integer(forKey: target)
        
        if Int(updateDrinkWater) < 0 {
            UserDefaults.standard.set(0, forKey: target)
            l.text = String(UserDefaults.standard.integer(forKey: target)) + " ml"
        } else {
            l.text = String(updateDrinkWater) + " ml"
        }
    }
    
    //익스텐션과 컴포넌트를 활용하여 코드를 조금 더 단순하게 제작함.
    //각각의 날짜를 저장하여 날짜가 달라지면 마신 물의 양을 초기화
    
    //물 마시기 버튼을 누를때, 오늘의 날짜를 저장
    func drinkWaterButtonClickedRecordDate( _ key: String){
        let now = Date().day
        UserDefaults.standard.set(now, forKey: key)
    }
    
    //화면이 실행될때 오늘의 날짜를 저장
    func viewWillAppearLoardRecordDate( _ key: String){
        let now = Date().day
        UserDefaults.standard.set(now, forKey: key)
    }
    
    //저장된 두 날짜를 비교하여 동일하면 그대로 출력, 다르면 리셋
    func compareTwoRecordDate(){
        let drinkWaterButtonClickedRecordDate = UserDefaults.standard.string(forKey: "RecordDate")
        let viewWillAppearRecordDate = UserDefaults.standard.string(forKey: "NowDate")
        
        if drinkWaterButtonClickedRecordDate == viewWillAppearRecordDate {
            DrinkButtonClicked(nowDrinkWater, "water")
        }else {
            UserDefaults.standard.removeObject(forKey: "water")
            DrinkButtonClicked(nowDrinkWater, "water")
        }
    }
    //Date의 시차 설정은 어케??
}

extension Date{
    var day: Int {
        let cal = Calendar.current
        return cal.component(.day, from: self)
    }
}
