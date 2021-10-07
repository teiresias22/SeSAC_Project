import UIKit

class EctViewController: UIViewController {
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var datePicker100: UILabel!
    @IBOutlet var datePicker200: UILabel!
    @IBOutlet var datePicker300: UILabel!
    @IBOutlet var datePicker400: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 14.0, *) {
        datePicker.preferredDatePickerStyle = .inline
        }else {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
    }
    @IBAction func datePickerValueChange(_ sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        
        dateFormat.locale = Locale(identifier: "ko_KR")
        dateFormat.dateFormat = "yyyy년 \n MM월 dd일"
        
        let afterDate100 = Date(timeInterval: 86400 * 100, since: sender.date)
        let afterDate200 = Date(timeInterval: 86400 * 200, since: sender.date)
        let afterDate300 = Date(timeInterval: 86400 * 300, since: sender.date)
        let afterDate400 = Date(timeInterval: 86400 * 400, since: sender.date)
        
        datePicker100.text = dateFormat.string(from: afterDate100)
        datePicker200.text = dateFormat.string(from: afterDate200)
        datePicker300.text = dateFormat.string(from: afterDate300)
        datePicker400.text = dateFormat.string(from: afterDate400)
        
    }
    

}
