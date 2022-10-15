import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var allCountLabel: UILabel!
    
    let localRealm = try! Realm()
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.delegate = self
        calendarView.dataSource = self
        
        tasks = localRealm.objects(UserDiary.self)
        
        //let allCount = localRealm.objects(UserDiary.self).count
        let allCount = getAllDiaryCountFromUserDiary()
        allCountLabel.text = "총 \(allCount)개 작성"
        
        let recent = localRealm.objects(UserDiary.self).sorted(byKeyPath: "writeDate", ascending: false).first?.diaryTitle
        print("recent: \(recent)")
        let old = localRealm.objects(UserDiary.self).sorted(byKeyPath: "writeDate", ascending: false).last?.diaryTitle
        print("old: \(old)")
        let full = localRealm.objects(UserDiary.self).filter("content != nil").count
        print("full: \(full)")
        let favorite = localRealm.objects(UserDiary.self).filter("favorite = false").count
        print("favorite: \(favorite)")
        
        let search = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] '일기' or content CONTAINS[c] '살아와'")
        print("search: \(search)")
        
        
        
        // Do any additional setup after loading the view.
    }
    

}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    //func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
    //    return "title"
    //}
    //func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {

    //    return "subTitle"
    //}    //func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
    //    return UIImage(systemName: "star")
    //}
    
    //Date: 시분초까지 모두 동일해야 함.
    //1. 영국표준시 기준으로 표기
    //2. 데이트 포멧터 사용
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        /*
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        let test = "20211103"
        
        if format.date(from: test) == date {
            return 3
        } else {
            return 1
        }*/
        return tasks.filter("writeDate = %@", date).count
        
    }
    
    
}
