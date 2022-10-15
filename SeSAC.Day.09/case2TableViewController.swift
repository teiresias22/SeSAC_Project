import UIKit

class case2TableViewController: UITableViewController {

    @IBOutlet weak var titlePageLabel: UILabel!
    var se1 = ["공지사항", "실험실", "버전 정보"]
    var se2 = ["개인/보안", "알림", "채팅", "멀티프로필"]
    var se3 = ["고객센터/도움말"]
    
    var header = ["전체설정", "개인 설정", "기타"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        titlePageLabel.text = "설정"
        titlePageLabel.textAlignment = .center
        titlePageLabel.textColor = .white
        titlePageLabel.font = .systemFont(ofSize: 20)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "전체 설정"
        } else if section == 1 {
            return "개인 설정"
        } else {
            return "기타"
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if editingStyle == .delete{
                se1.remove(at: indexPath.row)
            }
        } else if indexPath.section == 1 {
            if editingStyle == .delete{
                se2.remove(at: indexPath.row)
            }
        } else {
            if editingStyle == .delete{
                se3.remove(at: indexPath.row)
                
            }
        }
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return se1.count
        } else if section == 1 {
            return se2.count
        } else {
            return se3.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            cell.textLabel?.text = se1[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = se2[indexPath.row]
        } else {
            cell.textLabel?.text = se3[indexPath.row]
        }
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .boldSystemFont(ofSize: 13)
        cell.backgroundColor = .black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}
