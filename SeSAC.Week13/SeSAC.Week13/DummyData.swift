//
//  DummyData.swift
//  SeSAC.Week13
//
//  Created by Joonhwan Jeon on 2022/01/07.
//

import UIKit


class DummyViewModel {
    var data: [String] = Array(repeating: "테스트", count: 100)
}

extension DummyViewModel: UITableViewCellRepresentable {
    var numberOfSection: Int {
        return 1
    }
    
    var heightOfRowAt: CGFloat {
        return 60
    }
    
    func cellForRowAt(_ tableView: UITableView, IndexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: IndexPath)
        cell.textLabel?.text = data[IndexPath.row]
        return cell
    }
    
    var numberOfRowsInSection: Int {
        return data.count
    }
}
