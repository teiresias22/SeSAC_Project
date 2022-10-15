//
//  BoxOfficeCastViewController.swift
//  SeSAC.Day.09
//
//  Created by Joonhwan Jeon on 2021/10/15.
//

import UIKit

class BoxOfficeCastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "CAST \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

}
