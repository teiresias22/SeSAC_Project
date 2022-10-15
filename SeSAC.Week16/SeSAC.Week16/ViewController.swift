//
//  ViewController.swift
//  SeSAC.Week16
//
//  Created by Joonhwan Jeon on 2022/01/03.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

        viewModel.items
        .bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)

        
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }


}

class ViewModel {
    let items = Observable.just([
        "First Item",
        "Second Item",
        "Third Item"
    ])
}
