import Foundation

extension DateFormatter{
    var customFormat: DateFormatter {
        let date = DateFormatter()
        date.dateFormat = "yyyy년 MM월 dd일"
        return date
    }
}
