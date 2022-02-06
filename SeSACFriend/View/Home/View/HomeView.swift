//
//  HomeView.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/25.
//

import UIKit
import MapKit
import SnapKit

class HomeView: UIView, ViewRepresentable {
    
    let mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
        view.isZoomEnabled = true
        view.isScrollEnabled = true
        
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "map_marker")
        
        return view
    }()
    
    let genderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .customWhite
        
        return view
    }()
    
    let genderStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 0
        view.alignment = .fill
        view.distribution = .fillEqually
        
        return view
    }()
    
    let allButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체", for: .normal)
        button.titleLabel?.font = UIFont.Title3_M14
        button.setTitleColor(.customWhite, for: .normal)
        button.backgroundColor = .customGreen
        button.layer.cornerRadius = 8
        button.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        return button
    }()
    
    let manButton: UIButton = {
        let button = UIButton()
        button.setTitle("남자", for: .normal)
        button.titleLabel?.font = UIFont.Title3_M14
        button.setTitleColor(.customBlack, for: .normal)
        
        return button
    }()
    
    let womanButton: UIButton = {
        let button = UIButton()
        button.setTitle("여자", for: .normal)
        button.titleLabel?.font = UIFont.Title3_M14
        button.setTitleColor(.customBlack, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
        
        return button
    }()
    
    let myLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_place"), for: .normal)
        button.backgroundColor = .customWhite
        button.tintColor = .customBlack
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    let stateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_magnifying"), for: .normal)
        button.backgroundColor = .customBlack
        button.tintColor = .customWhite
        button.layer.cornerRadius = 32
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(mapView)
        mapView.addSubview(imageView)
        addSubview(genderView)
        genderView.addSubview(genderStackView)
        genderStackView.addArrangedSubview(allButton)
        genderStackView.addArrangedSubview(manButton)
        genderStackView.addArrangedSubview(womanButton)
        
        addSubview(myLocationButton)
        addSubview(stateButton)
        
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(48)
        }
        
        genderView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(52)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(48)
            make.height.equalTo(144)
        }
        
        genderStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        myLocationButton.snp.makeConstraints { make in
            make.top.equalTo(genderView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(48)
            make.height.equalTo(48)
        }
        
        stateButton.snp.makeConstraints { make in
            make.bottom.equalTo(mapView.snp.bottom).inset(96)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(64)
            make.height.equalTo(64)
        }
        
    }
}
