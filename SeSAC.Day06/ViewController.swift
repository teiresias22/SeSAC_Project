import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        view.backgroundColor = setViewBackground()
        
        setViewBackground()
        
    }
    
    func requestNorificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if success {
                self.sendNotification()
            }
        }
    }
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "물 마실 시간이에요!"
        notificationContent.body = "하루 2리터 목표 달성을 위해 열심히 달려보아요"
        notificationContent.badge = 100
        
        //언제 보낼 지 설정: 1. 간격, 2. 캘린더, 3. 위치
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        
        //알림 요청
        let request = UNNotificationRequest(identifier: "\(Date())",
                                            content: notificationContent,
                                            trigger: trigger)

        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    
    @IBAction func showAlert(_ sender: UIButton) {
        
        //1. UIAlertController 생성 : 밑바탕 + 타이틀 + 본문
        let alert = UIAlertController(title: "타이틀 텍스트", message: "메세지가 입력되었습니다.", preferredStyle: .actionSheet)
        
        //2. UIAlertAction 생성: 버튼들 설정
        let ok = UIAlertAction(title: "버튼1", style: .default)
        let ok2 = UIAlertAction(title: "버튼2", style: .cancel)
        let ok3 = UIAlertAction(title: "버튼3", style: .destructive)
        let ok4 = UIAlertAction(title: "버튼4", style: .default)
        
        //3. 1+2
        alert.addAction(ok2)
        alert.addAction(ok3)
        alert.addAction(ok)
        alert.addAction(ok4)
        
        //컬러피커
        //let colorPicker = UIColorPickerViewController()
        //present(colorPicker, animated: true, completion: nil)
        
        //4. Present
        present(alert, animated: true, completion: nil)
        
    }
    
    //1. 반환값 타입을 옵셔널 타입으로 변경 UIColor -> UIColor?
    //2. 출력값의 옵셔널을 강제 해제 random.randomElement()!
    //3. 반환될 값: ?? random.randomElement() ?? UIColor.white
    @discardableResult
    func setViewBackground() -> UIColor {
        let random: [UIColor] = [.red, .black, .gray, .green, .orange]
        return random.randomElement()!
    }

}

