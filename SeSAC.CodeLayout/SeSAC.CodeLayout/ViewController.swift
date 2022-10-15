//
//  ViewController.swift
//  SeSAC.CodeLayout
//
//  Created by Joonhwan Jeon on 2022/01/04.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        view.backgroundColor = .white
        [scrollView, topView].forEach {
            view.addSubview($0)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view).multipliedBy(1)
            make.height.equalTo(2000)
        }
        
        topView.snp.makeConstraints { make in
            make.leading.equalTo(scrollView)
            make.trailing.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.height.equalTo(view).multipliedBy(0.7)
        }
        
        
        
    }


}

