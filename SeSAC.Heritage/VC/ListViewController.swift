import UIKit
import RealmSwift

class ListViewController: UIViewController {
    
    @IBOutlet weak var topButtonView: UIView!
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topLeftUnderBarView: UIView!
    @IBOutlet weak var topLeftBackground: UIView!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var topRightUnderBarView: UIView!
    @IBOutlet weak var topRightBackground: UIView!
    
    @IBOutlet weak var listBarButton: TabBarButton!
    @IBOutlet weak var SearchBarButton: TabBarButton!
    @IBOutlet weak var mapBarButton: TabBarButton!
    @IBOutlet weak var myBarButton: TabBarButton!
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    let listInformation = ListInformation()
    let stockCodeInformation = StockCodeInformation()
    let cityInformation = CityInformation()
    var target: String = "StockCode"
    
    var buttonActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JHeritage".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 20)!]
                
        let nibName = UINib(nibName: ListCategoryCollectionViewCell.identifier, bundle: nil)
        listCollectionView.register(nibName, forCellWithReuseIdentifier: ListCategoryCollectionViewCell.identifier)
        
         // Do any additional setup after loading the view.
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        topRightButtonSet()
        topLeftButtonSet()
        
        topButtonView.backgroundColor = .clear
        listCollectionViewSet()
        secTabBarButtons()
        
        //print(">>\(UserDefaults.standard.object(forKey: "AppleLanguages"))<<")
    }
    
    func topRightButtonSet(){
        topRightButton.setTitle(listInformation.list[0].title, for: .normal)
        if buttonActive {
            topRightButton.titleLabel?.font = UIFont(name: "MapoFlowerIsland", size: 14)
            topRightButton.tintColor = .customBlack
            topRightUnderBarView.backgroundColor = .clear
            topRightBackground.backgroundColor = .clear
            
        } else {
            topRightButton.titleLabel?.font = UIFont(name: "MapoFlowerIsland", size: 16)
            topRightButton.tintColor = .customBlue
            topRightUnderBarView.backgroundColor = .customBlue
            topRightBackground.backgroundColor = .white
        }
    }
    
    func topLeftButtonSet() {
        topLeftButton.setTitle(listInformation.list[1].title, for: .normal)
        if buttonActive {
            topLeftButton.titleLabel?.font = UIFont(name: "MapoFlowerIsland", size: 16)
            topLeftButton.tintColor = .customBlue
            topLeftUnderBarView.backgroundColor = .customBlue
            topLeftBackground.backgroundColor = .white
        } else {
            topLeftButton.titleLabel?.font = UIFont(name: "MapoFlowerIsland", size: 14)
            topLeftButton.tintColor = .customBlack
            topLeftUnderBarView.backgroundColor = .clear
            topLeftBackground.backgroundColor = .clear
        }
    }
    
    @IBAction func topLeftButtonClicked(_ sender: UIButton) {
        buttonActive = true
        target = listInformation.list[0].target
        
        listCollectionView.reloadData()
        topRightButtonSet()
        topLeftButtonSet()
    }
    
    @IBAction func topRightButtonClicked(_ sender: UIButton) {
        buttonActive = false
        target = listInformation.list[1].target
        
        listCollectionView.reloadData()
        topRightButtonSet()
        topLeftButtonSet()
    }
    
    func listCollectionViewSet() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = listCollectionView.frame.width - (spacing * 5)
        
        layout.itemSize = CGSize(width: width / 4 , height: width / 2.2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing * 2, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        listCollectionView.collectionViewLayout = layout
        listCollectionView.backgroundColor = .clear
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if target == "StockCode" {
            return stockCodeInformation.stockCode.count
        }else {
            return cityInformation.city.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: ListCategoryCollectionViewCell.identifier, for: indexPath) as? ListCategoryCollectionViewCell else { return UICollectionViewCell() }
        item.backgroundColor = .clear
        
        if target == "StockCode" {
            if let url = URL(string: stockCodeInformation.stockCode[indexPath.row].image){
                item.listCategoryImage.kf.setImage(with: url)
            } else {
                item.listCategoryImage.image = UIImage(systemName: "star")
                item.listCategoryImage.backgroundColor = .customYellow
            }
            item.listCategoryLabel.text = stockCodeInformation.stockCode[indexPath.row].text.lowercased()
            item.listCategoryImage.layer.borderWidth = 2
            item.listCategoryImage.layer.borderColor = UIColor.customYellow?.cgColor
        } else if target == "City" {
            if let url = URL(string: cityInformation.city[indexPath.row].image){
                item.listCategoryImage.kf.setImage(with: url)
            } else {
                item.listCategoryImage.image = UIImage(systemName: "star")
                item.listCategoryImage.backgroundColor = .customBlue
            }
            item.listCategoryLabel.text = cityInformation.city[indexPath.row].city.lowercased()
            item.listCategoryImage.layer.borderWidth = 2
            item.listCategoryImage.layer.borderColor = UIColor.customBlue?.cgColor
        }
        item.listCategoryLabel.font = UIFont().MapoFlowerIsland14
        
        let width = item.frame.width
        item.listCategoryImage.layer.cornerRadius = width/2
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "ListTable", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ListTableViewController") as! ListTableViewController
        
        if target == "StockCode" {
            let row = stockCodeInformation.stockCode[indexPath.row]
            vc.stockCodeData = row
        } else {
            let row = cityInformation.city[indexPath.row]
            vc.cityData = row
        }
        
        vc.listInformation = target
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ListViewController {
    func secTabBarButtons() {
        setBarButton(listBarButton, "list.dash")
        listBarButton.tabBarButton.addTarget(self, action: #selector(listButtonClicked), for: .touchUpInside)
        
        setBarButton(SearchBarButton, "magnifyingglass")
        SearchBarButton.tabBarButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
        setBarButton(mapBarButton, "map")
        mapBarButton.tabBarButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
        
        setBarButton(myBarButton, "person")
        myBarButton.tabBarButton.addTarget(self, action: #selector(mypageButtonClicked), for: .touchUpInside)
    }
    
    @objc func listButtonClicked() {
        guard let vc = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as? ListViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: false, completion: nil)
    }
    
    @objc func searchButtonClicked() {
        guard let vc = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: false, completion: nil)
    }
    
    @objc func mapButtonClicked() {
        guard let vc = UIStoryboard(name: "Map", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: false, completion: nil)
    }
    
    @objc func mypageButtonClicked() {
        guard let vc = UIStoryboard(name: "ListUp", bundle: nil).instantiateViewController(withIdentifier: "ListUpViewController") as? ListUpViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: false, completion: nil)
    }
    
    func setBarButton(_ target: TabBarButton, _ image: String){
        target.tabBarButton.setImage(UIImage(systemName: image), for: .normal)
        target.tabBarButton.imageEdgeInsets = UIEdgeInsets(top: 16, left: 36, bottom: 28, right: 36)
        target.tabBarButton.contentMode = .scaleToFill
        target.tabBarButton.setTitle("", for: .normal)
        target.tabBarButton.contentVerticalAlignment = .fill
        target.tabBarButton.contentHorizontalAlignment = .fill
        listBarButton.tabBarActiveView.backgroundColor = .customBlue
    }
}
