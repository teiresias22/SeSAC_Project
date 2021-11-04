import UIKit

//DatePicker에서 선택된 날짜를 활용
extension Date {
    //API호출에 필요한 양식
    func setDateString(_ data: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: data)
    }
    //boxofficeTitleLabel에 포시해줄 월
    func setYearString(_ data: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: data)
    }
    //boxofficeTitleLabel에 포시해줄 월
    func setMonthString(_ data: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: data)
    }
    //boxofficeTitleLabel에 포시해줄 일
    func setDayString(_ data: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: data)
    }
}
