import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON

class BoxofficeViewController: UIViewController {
    @IBOutlet weak var boxofficeTitleLabel: UILabel!
    @IBOutlet weak var boxofficeTableView: UITableView!
    @IBOutlet weak var boxofficeDatePicker: UIDatePicker!
    
    var boxofficeData: [BoxofficeModel] = []
    var setDate: String = "20211103"
    
    var taskList: Results<BoxofficeRank>!
    var filterList: Results<BoxofficeRank>!
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boxofficeTableView.delegate = self
        boxofficeTableView.dataSource = self
        
        let nibName = UINib(nibName: BoxofficeTableViewCell.identifier, bundle: nil)
        boxofficeTableView.register(nibName, forCellReuseIdentifier: BoxofficeTableViewCell.identifier)
        
        taskList = localRealm.objects(BoxofficeRank.self)
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        setAttributes()
        checkRealmData()
    }
    
    func checkRealmData() {
        let predicate = NSPredicate(format: "nowDate == %@", setDate)
        
        if taskList.filter(predicate).count == 0 {
            fetcMediaData(Date: setDate)
            print("처음 불러옴")
        } else {
            let filter = taskList.filter(predicate)
            filterList = filter
            print("데이터가 있음")
            
            boxofficeData = []
            
            for i in 0...9 {
                let rankData = filterList.first?.rankArray[i]
                let movieNmData = filterList.first?.movieNmArray[i]
                let openDtDate = filterList.first?.openDtArray[i]
                let rankOldAndNewData = filterList.first?.rankOldAmdNewArray[i]
                let audiAccData = filterList.first?.audiAccArray[i]
                let data = BoxofficeModel(rankData: rankData!, movieNmData: movieNmData!, openDtData: openDtDate!, rankOldAndNewData: rankOldAndNewData!, audiAccData: audiAccData!)
                
                boxofficeData.append(data)
            }
        }
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
        fetcMediaData(Date: setDate)
        boxofficeTitleLabel.text = "\(Date().setYearString(boxofficeDatePicker.date))년 \(Date().setMonthString(boxofficeDatePicker.date))월 \(Date().setDayString(boxofficeDatePicker.date))일 박스오피스"
    }
    
    func saveRealm(data: [BoxofficeModel], nowDate: String) {
        var rankData: [String] = []
        var movieNmData: [String] = []
        var openDtDate: [String] = []
        var rankOldAndNewData: [String] = []
        var audiAccData: [String] = []
        for i in (0...9) {
            rankData.append(data[i].rankData)
            movieNmData.append(data[i].movieNmData)
            openDtDate.append(data[i].openDtData)
            rankOldAndNewData.append(data[i].rankOldAndNewData)
            audiAccData.append(data[i].audiAccData)
        }
        let task = BoxofficeRank(rankArray: rankData, movieNmArray: movieNmData, openDtArray: openDtDate, rankOldAndNewArray: rankOldAndNewData, audiAccArray: audiAccData, nowDate: setDate)
        
        //print("saveRealm task", task)
        try! localRealm.write{
            localRealm.add(task)
        }
        
        self.boxofficeTableView.reloadData()
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
        if row.rankData == "1"{
            cell.rankLabel.textColor = .customRed
        } else if row.rankData == "2"{
            cell.rankLabel.textColor = .customBlue
        } else {
            cell.rankLabel.textColor = .customGreen
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
        //데이터를 새로 불러오는데 왜 신규 등록 베너가 자꾸만 생성되는건지??
        
        cell.audiAccLabel.text = "누적 관객수 : \(row.audiAccData)"
        cell.audiAccLabel.textColor = .customGreen
        
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 10
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        
        let row = boxofficeData[indexPath.row]
        vc.boxofficeData = row
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetcMediaData(Date: String) {
        
        boxofficeData = []
        
        KobisAPIManager.shared.fetchBoxofficeData(nowDate: setDate) { json in
            for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                let rank = movie["rank"].stringValue
                let audiAcc = movie["audiAcc"].stringValue
                let movieNm = movie["movieNm"].stringValue
                let openDt = movie["openDt"].stringValue
                let rankOldAndNew = movie["rankOldAndNew"].stringValue
                        
                let data = BoxofficeModel(rankData: rank, movieNmData: movieNm, openDtData: openDt, rankOldAndNewData: rankOldAndNew, audiAccData: audiAcc)
                self.boxofficeData.append(data)
            }
            self.saveRealm(data: self.boxofficeData, nowDate: self.setDate)
            self.boxofficeTableView.reloadData()
        }
    }
}
