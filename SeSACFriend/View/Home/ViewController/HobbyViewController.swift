//
//  HobbyViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/02/05.
//

import UIKit
import FirebaseAuth

class HobbyViewController: BaseViewController {
    let mainView = HobbyView()
    var viewModel: HomeViewModel!
    
    private let HobbyViewControllerCellId = "HobbyViewControllerCellId"
    
    var systemRecomend: Array<String> = ["아무거나", "SeSAC", "코딩"]
    var otherUserRecomend: Array<String> = ["맛집탐방", "공원산책", "독서모임", "다육이", "쓰레기줍기"]
    
    var topTextArray: Array<String> = []
    var bottomTextArray: Array<String> = ["코딩", "클라이밍", "달리기", "자전거", "사진", "필름카메라", "전시관람", "게임"]
    
    override func loadView() {
        self.view = mainView
        
        topTextArray += systemRecomend
        topTextArray += otherUserRecomend
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setSearchBar()
        mainView.submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
    }
    
    override func configure() {
        mainView.topColectionView.delegate = self
        mainView.topColectionView.dataSource = self
        mainView.topColectionView.register(HobbyCollectionViewCell.self, forCellWithReuseIdentifier: HobbyViewControllerCellId)
        
        mainView.bottomColectionView.delegate = self
        mainView.bottomColectionView.dataSource = self
        mainView.bottomColectionView.register(HobbyCollectionViewCell.self, forCellWithReuseIdentifier: HobbyViewControllerCellId)
    }
    
    func setSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.titleView = searchBar
    }
    
    @objc func submitButtonClicked() {
        let vc = NearUserViewController()
        vc.viewModel = self.viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HobbyViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.topColectionView {
            return topTextArray.count
        } else {
            return bottomTextArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.topColectionView {
            guard let item = mainView.topColectionView.dequeueReusableCell(withReuseIdentifier: HobbyViewControllerCellId, for: indexPath) as? HobbyCollectionViewCell else { return UICollectionViewCell() }
            item.textLabel.text = topTextArray[indexPath.row]
            
            if indexPath.row < 3 {
                item.textLabel.textColor = .error
                item.textLabel.layer.borderColor = UIColor.error?.cgColor
            } else {
                item.textLabel.textColor = .customBlack
                item.textLabel.layer.borderColor = UIColor.customGray4?.cgColor
            }
            
            return item
        } else {
            guard let item = mainView.bottomColectionView.dequeueReusableCell(withReuseIdentifier: HobbyViewControllerCellId, for: indexPath) as? HobbyCollectionViewCell else { return UICollectionViewCell() }
            item.textLabel.text = bottomTextArray[indexPath.row]
            item.textLabel.textColor = .customGreen
            item.textLabel.layer.borderColor = UIColor.customGreen?.cgColor
            
            return item
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainView.bottomColectionView {
            bottomTextArray.remove(at: indexPath.row)
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
