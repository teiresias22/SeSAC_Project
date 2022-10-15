//
//  UITableViewCell+Extention.swift
//  SeSAC.Week13
//
//  Created by Joonhwan Jeon on 2022/01/07.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
