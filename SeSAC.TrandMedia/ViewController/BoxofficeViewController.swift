import UIKit
import Alamofire
import SwiftyJSON

class BoxofficeViewController: UIViewController {

    var boxofficeData: [BoxofficeModel] = []
    
    @IBOutlet weak var boxofficeTitleLabel: UILabel!
    @IBOutlet weak var boxofficeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxofficeTableView.delegate = self
        boxofficeTableView.dataSource = self
        
        boxofficeTitleLabel.text = "박스오피스 \(Date().month)월 \(Date().day - 1)일 "
        
        let nibName = UINib(nibName: BoxofficeTableViewCell.identifier, bundle: nil)
        boxofficeTableView.register(nibName, forCellReuseIdentifier: BoxofficeTableViewCell.identifier)
        
        BoxOfficeDataSetting()
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
        let setDate = "\(Date().year)\(Date().month)\(Date().day - 1)"
        print("setDate\(setDate)")
        
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
