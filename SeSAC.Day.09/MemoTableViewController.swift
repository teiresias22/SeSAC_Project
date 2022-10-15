//
//  MemoTableViewController.swift
//  SeSAC.Day.09
//
//  Created by Joonhwan Jeon on 2021/10/12.
//

import UIKit

class MemoTableViewController: UITableViewController {

    //var list = [Memo]() {} 아래와 동일한 코드
    var list: [Memo] = []{
        didSet {
            saveData()
        }
    }
    
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        loadData()
        
    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        if let text = memoTextView.text {
            
            let segmentIndex = categorySegmentedControl.selectedSegmentIndex
            
            let segmentCategory = Category(rawValue: segmentIndex) ?? .others
            
            let memo = Memo(content: text, category: segmentCategory)
            
            
            
            list.append(memo)
            
            //추가한 테이블뷰 적용하여 화면에 표시
            //tableView.reloadData()
            
            print(list)
        }else {
            print("값을 추가할 수 없습니다.")
        }
    }
    func loadData() {
        
        let userDefaults = UserDefaults.standard
        
        if let data = userDefaults.object(forKey: "memoList") as? [[String:Any]] {
            var memo = [Memo]()
            
            for datum in data {
                
                guard let category = datum ["category"] as? Int else { return }
                guard let content = datum ["content"] as? String else { return }
                
                let enumCategory = Category(rawValue: category) ?? .others
                
                memo.append(Memo(content: content, category: enumCategory))
            }
            
            self.list = memo
        }
        
        
    }
    
    
    
    
    func saveData() {
        var memo: [[String:Any]] = []
        
        for i in list {
            let data: [String:Any] = [
                "category": i.category.rawValue,
                "content": i.content
            ]
            
            memo.append(data)
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(memo, forKey: "memoList")
        
        tableView.reloadData()
    }
    
    
    
    //옵션: 섹션의 갯수 설정 numberOfSections //Default 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //옵션: 색션 헤더 설정 titleForHeaderInSection //Default none
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "섹션 헤더"
    }
    
    //옵션: 색션 푸터 설정 titleForFooterInSection //Default none
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "섹션 푸터"
    }
    
    //옵션: 셀 스와이프 On / Off 여부 canEditRowAt
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? false : true
    }
    
    //옵션: 셀 스와이프시 할 행동 표시 commit editingStyle //
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            if editingStyle == .delete{
                list.remove(at: indexPath.row)
                //tableView.reloadData()
            }
        }
    }
    
    //옵션: 셀을 선택했을 때
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀 선택!")
    }
    
    //1. 셀의 갯수 numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /*
        if section == 0 {
            return 2
        } else {
            return 4
        }
        */
        
        return section == 0 ? 2 : list.count
    }
    
    //2. 셀의 디자인 및 데이터 처리 cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(#function)
        
        //Early Exit
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") else{
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "첫번째 섹션입니다. - \(indexPath)"
            cell.textLabel?.textColor = .brown
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        } else {
            /*
            if indexPath.row == 0 {
                cell?.textLabel?.text = list[0]
            }else if indexPath.row == 1 {
                cell?.textLabel?.text = list[1]
            }else if indexPath.row == 2 {
                cell?.textLabel?.text = list[2]
            }else if indexPath.row == 3 {
                cell?.textLabel?.text = list[3]
            }else if indexPath.row == 4 {
                cell?.textLabel?.text = list[4]
            }else {
                cell?.textLabel?.text = "데이터 없음"
            }
            위 조건문의 indexPath.row와 list[]배열의 숫자는 같기 때문에
            cell?.textLabel?.text = list[indexPath.row] 와 동일한 조건문이 된다.
            */
            
            let row = list[indexPath.row]
            
            cell.textLabel?.text = row.content
            cell.detailTextLabel?.text = row.category.description
            cell.textLabel?.textColor = .blue
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            
            switch row.category {
            case .business: cell.imageView?.image = UIImage(systemName: "building.2")
            case .personal: cell.imageView?.image = UIImage(systemName: "person")
            case .others: cell.imageView?.image = UIImage(systemName: "square.and.pencil")
            }
            
            cell.imageView?.tintColor = .red
        }
        
        return cell
        
    }
    //3. 셀의 높이 heightForRowAt
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 무조건 높이가 80
        //return 80
        
        //섹션 0번은 80, 그 외에는 44
        return indexPath.section == 0 ? 80 : 44
        
        //각 섹션의 0번째 로우는 44 그 외에는 80
        //return indexPath.row == 0 ? 44 : 80
    }
}
