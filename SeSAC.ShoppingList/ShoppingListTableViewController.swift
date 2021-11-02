import UIKit
import RealmSwift

class ShoppingListTableViewController: UITableViewController {
    @IBOutlet weak var addShoppingListText: UITextField!
    
    let localRealm = try! Realm()
    var tasks: Results<shoppingList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = localRealm.objects(shoppingList.self)
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        dataSave()
        addShoppingListText.text = ""
    }
    
    func dataSave() {
        let task = shoppingList(title: addShoppingListText.text!)
        try! localRealm.write {
            localRealm.add(task)
        }
        tableView.reloadData()
    }
    
    //셀 스와이프 On / Off 여부 canEditRowAt
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //셀 스와이프시 할 행동 표시 commit editingStyle //
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
        //list.remove(at: indexPath.row)
        }
    }
    
    //셀의 갯수 numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    //셀의 디자인 및 데이터 처리 cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier, for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        
        let row = tasks[indexPath.row]
        
        if row.complete {
            cell.CheckBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }else {
            cell.CheckBoxButton.setImage(UIImage(systemName: "squareshape"), for: .normal)
        }
        
        if row.favorite {
            cell.FavoritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else {
            cell.FavoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        
        cell.ContentLabel?.text = row.title
        
        return cell
    }
    //셀의 높이 heightForRowAt
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 14
    }

}
