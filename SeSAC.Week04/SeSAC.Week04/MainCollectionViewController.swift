import UIKit
//tableView -> CollectionView
//row -> item

class MainCollectionViewController: UIViewController {

    // CollectionView 아웃렛 연결
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    var mainArray = Array(repeating: false, count: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //3. Delegate
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self

        //4. XIB
        let nibName = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        mainCollectionView.register(nibName, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        let tagNibName = UINib(nibName: TagCollectionViewCell.identifier, bundle: nil)
        tagCollectionView.register(tagNibName, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3 , height: (width / 3 ) / 0.8 )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        mainCollectionView.collectionViewLayout = layout
        
        mainCollectionView.backgroundColor = .lightGray
        
        let tagLayout = UICollectionViewFlowLayout()
        let tagSpacing: CGFloat = 8
        tagLayout.scrollDirection = .horizontal
        tagLayout.itemSize = CGSize(width: 100, height: 40)
        tagLayout.minimumInteritemSpacing = tagSpacing
        tagLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        tagCollectionView.collectionViewLayout = tagLayout
        tagCollectionView.backgroundColor = .systemPink
    }
    
    @objc func heartButtonClicked(selectButton: UIButton){
        
        //if mainArray[selectButton.tag] == true{
        //    mainArray[selectButton.tag] = false
        //}else {
        //    mainArray[selectButton.tag] = true
        //}
        mainArray[selectButton.tag] = !mainArray[selectButton.tag]
        
        //mainCollectionView.reloadData()
        mainCollectionView.reloadItems(at: [IndexPath(item: selectButton.tag, section: 0)])
        
        print("\(selectButton.tag) 버튼 클릭!")
    }
}

//2. CollectionView Extension
extension MainCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            return 10
        } else {
            return mainArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
            
            cell.tagLabel.text = "태그컬랙션 뷰"
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
            
            let item = mainArray[indexPath.item]
            
            cell.mainImageView.backgroundColor = .blue
            let image = item/* == true 생략 가능*/ ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            cell.heartButton.setImage(image, for: .normal)
            cell.heartButton.tag = indexPath.item
            cell.heartButton.addTarget(self, action: #selector(heartButtonClicked(selectButton:)), for: .touchUpInside)
            
            return cell
        }
        
        
        
    }
    
}
