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
    }
    
    override func configure() {
        
        mainView.topColectionView.delegate = self
        mainView.topColectionView.dataSource = self
        mainView.topColectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: HobbyCollectionViewCell.identifier)
        
        mainView.bottomColectionView.delegate = self
        mainView.bottomColectionView.dataSource = self
        mainView.topColectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: HobbyCollectionViewCell.identifier)
    }
    
}

extension HobbyViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == mainView.bottomColectionView {
            bottomTextArray.remove(at: indexPath.row)
        }
    }
    
}

extension HobbyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.topColectionView {
            return topTextArray.count
        } else {
            return bottomTextArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == mainView.topColectionView {
            guard let item = mainView.topColectionView.dequeueReusableCell(withReuseIdentifier: HobbyCollectionViewCell.identifier, for: indexPath) as? HobbyCollectionViewCell else { return UICollectionViewCell() }
            item.textLabel.text = topTextArray[indexPath.row]
            
            if indexPath.row <= 3 {
                item.textLabel.textColor = .error
                item.textLabel.layer.borderColor = UIColor.error?.cgColor
            }
            
            return item
        } else {
            guard let item = mainView.bottomColectionView.dequeueReusableCell(withReuseIdentifier: HobbyCollectionViewCell.identifier, for: indexPath) as? HobbyCollectionViewCell else { return UICollectionViewCell() }
            item.textLabel.text = bottomTextArray[indexPath.row]
            
            return item
        }
    }
    
}


class CollectionViewLeftAlignFlowLayout: UICollectionViewFlowLayout {
    let cellspacing: CGFloat = 8
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumInteritemSpacing = 8.0
        self.sectionInset = UIEdgeInsets(top: 12.0, left: 16.0, bottom: 0.0, right: 16.0)
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellspacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
    
}
