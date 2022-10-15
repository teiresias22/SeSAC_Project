//
//  SnapDetailViewController.swift
//  SeSAC.Week14
//
//  Created by Joonhwan Jeon on 2022/01/03.
//

import UIKit
import SnapKit

class SnapDetailViewController: UIViewController {
    
    let newActivateButton: MainActiveButton = {
        let button = MainActiveButton()
        button.setTitle("신규버튼", for: .normal)
        button.addTarget(self, action: #selector(activateButtonPushClicked), for: .touchDown)
        return button
    }()
    
    let activateButton: MainActiveButton = {
        let button = MainActiveButton()
        button.setTitle("다음", for: .normal)
        button.addTarget(self, action: #selector(activateButtonClicked), for: .touchUpInside)
        return button
    }()
    let moneyLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemYellow
        label.text = "13,532원"
        label.textAlignment = .center
        return label
    }()
    
    let descriptionLabel = UILabel()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let firstSquareView: SquarBoxView = {
        let view = SquarBoxView()
        view.label.text = "토스뱅크"
        view.imageView.image = UIImage(systemName: "trash.fill")
        return view
    }()
    
    let secondSquareView: SquarBoxView = {
        let view = SquarBoxView()
        view.label.text = "토스증권"
        view.imageView.image = UIImage(systemName: "chart.xyaxis.line")
        return view
    }()
    
    let thirdSquareView: SquarBoxView = {
        let view = SquarBoxView()
        view.label.text = "고객센터"
        view.imageView.image = UIImage(systemName: "person")
        return view
    }()
    
    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }()
    
    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //스텍뷰 추가
        view.addSubview(stackView)
        //스텍뷰에 아이템 추가
        stackView.addArrangedSubview(firstSquareView)
        stackView.addArrangedSubview(secondSquareView)
        stackView.addArrangedSubview(thirdSquareView)
        
        //스텍뷰 설정
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(28)
            $0.centerX.equalTo(view)
            $0.width.equalTo(view.snp.width).multipliedBy(1.0/1.0).inset(20)
            $0.height.equalTo(80)
        }
        
        firstSquareView.alpha = 0
        secondSquareView.alpha = 0
        thirdSquareView.alpha = 0
        
        //1초후 알파값 1로 변경
        //UIView.animate(withDuration: 1) {
        //    self.firstSquareView.alpha = 1
        //}
        
        UIView.animate(withDuration: 0.5) {
            self.firstSquareView.alpha = 1
        } completion: { bool in
            UIView.animate(withDuration: 0.5) {
                self.secondSquareView.alpha = 1
            } completion: { bool in
                UIView.animate(withDuration: 0.5) {
                    self.thirdSquareView.alpha = 1
                }
            }
        }
        
        view.backgroundColor = .white
        [activateButton, moneyLabel, descriptionLabel, redView, newActivateButton].forEach {
            view.addSubview($0)
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(80)
        }
        
        activateButton.snp.makeConstraints { make in
            make.leadingMargin.equalTo(view)
            make.trailingMargin.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view).multipliedBy(0.1)
        }
        
        newActivateButton.snp.makeConstraints { make in
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(activateButton)
            make.height.equalTo(view).multipliedBy(0.1)
        }
        
        redView.snp.makeConstraints { make in
//            make.top.equalTo(view)
//            make.leading.equalTo(view)
//            make.trailing.equalTo(view)
//            make.bottom.equalTo(view)
            make.edges.equalToSuperview().inset(150)
        }
        
        redView.snp.updateConstraints { make in
            make.bottom.equalTo(-600)
        }
        
        redView.addSubview(blueView)
        blueView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(50)
        }
    }
    
    @objc func activateButtonClicked() {
        let vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        vc.name = "고래밥"
        //let vc = DetailViewController() 코드로만 작성된 페이지인 경우
        present(vc, animated: true, completion: nil)
    }
    
    @objc func activateButtonPushClicked() {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
