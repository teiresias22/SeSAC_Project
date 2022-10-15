//
//  UITableViewCellRepresentable.swift
//  SeSAC.Week13
//
//  Created by Joonhwan Jeon on 2022/01/07.
//

import UIKit

protocol UITableViewCellRepresentable {
    
    var numberOfSection: Int { get }
    var numberOfRowsInSection: Int { get }
    var heightOfRowAt: CGFloat { get }
    func cellForRowAt(_ tableView: UITableView, IndexPath: IndexPath) -> UITableViewCell
}
