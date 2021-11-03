import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift
import SwiftUI

class BoxofficeViewController: UIViewController {
    @IBOutlet weak var boxofficeTitleLabel: UILabel!
    @IBOutlet weak var boxofficeTableView: UITableView!
    @IBOutlet weak var boxofficeDatePicker: UIDatePicker!
    
    var boxofficeData: [BoxofficeModel] = []
    var setDate = "20211027"
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxofficeTableView.delegate = self
        boxofficeTableView.dataSource = self
        
        boxofficeTitleLabel.text = "박스오피스 10월 27일 "
        
        let nibName = UINib(nibName: BoxofficeTableViewCell.identifier, bundle: nil)
        boxofficeTableView.register(nibName, forCellReuseIdentifier: BoxofficeTableViewCell.identifier)
        
        BoxOfficeDataSetting()
        setAttributes()
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    func setAttributes() {
        boxofficeDatePicker.preferredDatePickerStyle = .automatic
        boxofficeDatePicker.datePickerMode = .date
        boxofficeDatePicker.locale = Locale(identifier: "ko-KR")
        boxofficeDatePicker.timeZone = .autoupdatingCurrent
        boxofficeDatePicker.date = Date(timeIntervalSinceNow: -3600 * 24 * 1)
        
        var components = DateComponents()
        components.day = -1
        let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        components.day = -1000
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        boxofficeDatePicker.maximumDate = maxDate
        boxofficeDatePicker.minimumDate = minDate
        
        boxofficeDatePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }
    
    @objc
    func handleDatePicker(_ sender: UIDatePicker) {
        setDate = setDateString(boxofficeDatePicker.date)
        BoxOfficeDataSetting()
    }
    
    func setDateString(_ data: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let str = dateFormatter.string(from: data)
        return str
    }
    
    
}

extension BoxofficeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxofficeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxofficeTableViewCell.identifier, for: indexPath) as? BoxofficeTableViewCell else {
            return UITableViewCell()
        }
        let row = boxofficeData[indexPath.row]
        
        cell.rankLabel.text = row.rankData
        cell.rankLabel.textAlignment = .center
        if row.rankData == "1"{
            cell.rankLabel.textColor = .customRed
        } else {
            cell.rankLabel.textColor = .customBlue
        }
        
        cell.movieNmLabel.text = row.movieNmData
        
        cell.openDtLabel.text = "개봉일 : \(row.openDtData)"
        
        if row.rankOldAndNewData != "OLD" {
            cell.rankOldAndNewLabel.text = row.rankOldAndNewData
            cell.rankOldAndNewLabel.textColor = .customYellow
            cell.rankOldAndNewLabel.backgroundColor = .customRed
            cell.rankOldAndNewLabel.textAlignment = .center
        } else {
            cell.rankOldAndNewLabel.text = ""
        }
        
        cell.audiAccLabel.text = "누적 관객수 : \(row.audiAccData)"
        cell.audiAccLabel.textColor = .customGreen
        
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    
    func BoxOfficeDataSetting() {
        
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=\(setDate)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let rank = movie["rank"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let rankOldAndNew = movie["rankOldAndNew"].stringValue
                    
                    let data = BoxofficeModel(rankData: rank, movieNmData: movieNm, openDtData: openDt, rankOldAndNewData: rankOldAndNew, audiAccData: audiAcc)
                    
                    self.boxofficeData.append(data)
                }
                self.boxofficeTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DatePicker {
    
}


extension Date{
    var year: Int {
        let cal = Calendar.current
        return cal.component(.year, from: self)
    }
    var month: Int {
        let cal = Calendar.current
        return cal.component(.month, from: self)
    }
    var day: Int {
        let cal = Calendar.current
        return cal.component(.day, from: self)
    }
}
