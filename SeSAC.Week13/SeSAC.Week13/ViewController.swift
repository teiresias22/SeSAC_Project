//
//  ViewController.swift
//  SeSAC.Week13
//
//  Created by Joonhwan Jeon on 2022/01/06.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    
    var apiService = APIService()
    
    var castData: Cast?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        
        apiService.requestCast { cast in
            self.castData = cast
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castData?.peopleListResult.peopleList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier)
        cell?.textLabel?.text = castData?.peopleListResult.peopleList[indexPath.row].peopleNm
        cell?.detailTextLabel?.text = "aaaa"
        return cell!
    }
}

