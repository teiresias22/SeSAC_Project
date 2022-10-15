//
//  DetailViewController.swift
//  SeSAC.Week14
//
//  Created by Joonhwan Jeon on 2022/01/02.
//

import UIKit

class DetailViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let activateButton = MainActiveButton()
    

    let bannerView = BannerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.selectedImage = UIImage(systemName: "person")
        tabBarItem.image = UIImage(systemName: "person.circle")
        tabBarItem.title = "디테일뷰"
        
        [titleLabel, subTitleLabel, activateButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        view.backgroundColor = .white
        
        setTitleLabelConstraints()
        setSubTitleLabelConstraints()
        setActivateButtonConstrainsts()
    }
    
    func setTitleLabelConstraints() {
        titleLabel.text = "관심 있는 회사 \n3개를 선택해주세요"
        titleLabel.backgroundColor = .lightGray
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        //titleLabel.frame = CGRect(x: 100, y: 100, width: UIScreen.main.bounds.width - 200, height: 80)
        
        //view.addSubview(titleLabel)
        //titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //NSLayoutConstraints
        let topConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        let leadingConstraint = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 40)
        leadingConstraint.isActive = true
        let trailingConstraint = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -40)
        trailingConstraint.isActive = true
        let heightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 80)
        heightConstraint.isActive = true
    }
    
    func setSubTitleLabelConstraints() {
        subTitleLabel.text = "맞춤 정보를 알려드려요"
        subTitleLabel.backgroundColor = .darkGray
        subTitleLabel.font = .systemFont(ofSize: 16)
        subTitleLabel.textAlignment = .center
        
        //view.addSubview(subTitleLabel)
        //subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: subTitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint(item: subTitleLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: subTitleLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.7, constant: 0)
        let height = NSLayoutConstraint(item: subTitleLabel, attribute: .height, relatedBy: .equal, toItem: titleLabel, attribute: .height, multiplier: 0.5, constant: 0)
        
        view.addConstraints([topConstraint, centerX, width, height])
    }
    
    func setActivateButtonConstrainsts() {
        //view.addSubview(activateButton)
        //activateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activateButton.widthAnchor.constraint(equalToConstant: 300),
            activateButton.heightAnchor.constraint(equalToConstant: 50),
            activateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        
        
        
        
    }
}
