import UIKit

class EctViewController: UIViewController {
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 14.0, *) {
        datePicker.preferredDatePickerStyle = .inline
        }
        
        
    }
    @IBAction func datePickerValueChange(_ sender: UIDatePicker) {
        
        print(datePicker.date)
        print(sender.date)
        
        //DateFormatter: 1. 원하는 형태대로 날짜를 표기 2. 타임존에 맞춰서 시간 설정
        let format = DateFormatter()
        
        format.dateFormat = "yyyy년 MM월 dd일" //21/10/20
        let value = format.string(from: sender.date)
        print(value)
        
        //100일 뒤: TimeInterval
        let afterDate = Date(timeInterval: 86400 * 100, since: sender.date)
        print(afterDate)
        
    }
    

}
