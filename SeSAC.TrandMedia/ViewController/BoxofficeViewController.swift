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
    var setDate = "20211103"
    
    var taskList: Results<BoxofficeRank>!
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxofficeTableView.delegate = self
        boxofficeTableView.dataSource = self
        
        let nibName = UINib(nibName: BoxofficeTableViewCell.identifier, bundle: nil)
        boxofficeTableView.register(nibName, forCellReuseIdentifier: BoxofficeTableViewCell.identifier)
        
        BoxOfficeDataSetting()
        setAttributes()
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        taskList = localRealm.objects(BoxofficeRank.self)
    }
    
    func setAttributes() {
        boxofficeDatePicker.preferredDatePickerStyle = .automatic
        boxofficeDatePicker.datePickerMode = .date
        boxofficeDatePicker.locale = Locale(identifier: "ko-KR")
        boxofficeDatePicker.timeZone = .autoupdatingCurrent
        boxofficeDatePicker.date = Date(timeIntervalSinceNow: -3600 * 24 * 1)
        
        var components = DateComponents()
        //최대 선택 가능 일
        components.day = -1
        let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        
        //최소 선택 가능 일(집계 시작일로 해야 하는데 일단은.....)
        components.day = -1000
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        
        boxofficeDatePicker.maximumDate = maxDate
        boxofficeDatePicker.minimumDate = minDate
        
        boxofficeDatePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        
        boxofficeTitleLabel.text = "\(Date().setYearString(boxofficeDatePicker.date))년 \(Date().setMonthString(boxofficeDatePicker.date))월 \(Date().setDayString(boxofficeDatePicker.date))일 박스오피스"
    }
    
    @objc
    func handleDatePicker(_ sender: UIDatePicker) {
        setDate = Date().setDateString(boxofficeDatePicker.date)
        BoxOfficeDataSetting()
        boxofficeTitleLabel.text = "\(Date().setYearString(boxofficeDatePicker.date))년 \(Date().setMonthString(boxofficeDatePicker.date))월 \(Date().setDayString(boxofficeDatePicker.date))일 박스오피스"
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
        //데이터를 새로 불러오는데 왜 신규 등록 베너는 안바뀌는거지??
        
        cell.audiAccLabel.text = "누적 관객수 : \(row.audiAccData)"
        cell.audiAccLabel.textColor = .customGreen
        
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            boxofficeData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    func BoxOfficeDataSetting() {
        
        boxofficeData = []
        
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
