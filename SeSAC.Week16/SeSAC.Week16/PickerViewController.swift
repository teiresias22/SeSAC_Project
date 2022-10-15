//
//  PickerViewController.swift
//  SeSAC.Week16
//
//  Created by Joonhwan Jeon on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PickerViewController: UIViewController{
    
    let pickerView = UIPickerView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = Observable.just([
                "First Item",
                "Second Item",
                "Third Item"
            ])
     
        items
            .bind(to: pickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
    }
    
    func setup() {
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
}
