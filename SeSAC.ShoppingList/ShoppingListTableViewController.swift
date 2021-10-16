//
//  ShoppingListTableViewController.swift
//  SeSAC.ShoppingList
//
//  Created by Joonhwan Jeon on 2021/10/15.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
        
    @IBOutlet weak var addShoppingListText: UITextField!
    
    var list: [List] = []{
        didSet {
            saveData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()

    }
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        saveButton()
        addShoppingListText.text = ""
    }
    
    func saveButton() {
        if let text = addShoppingListText.text {
            let memo = List(CheckBox: "", Content: text, Favorites: "")
            list.append(memo)
            print(list)
        }else {
            print("ERROR")
        }
    }
    
    func saveData() {
        var listup: [[String: Any]] = []
        
        for i in list {
            let data: [String: Any] = ["Content": i.Content]
            listup.append(data)
        }
        UserDefaults.standard.set(listup, forKey: "shoppingList")
        tableView.reloadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.object(forKey: "shoppingList") as? [[String: Any]] {
            var listup = [List]()
            
            for datum in data {
                guard let Content = datum["Content"] as? String else { return }
                
                listup.append(List(CheckBox: "", Content: Content, Favorites: ""))
            }
            
            self.list = listup
        }
    }
    
    
    //셀 스와이프 On / Off 여부 canEditRowAt
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //셀 스와이프시 할 행동 표시 commit editingStyle //
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            list.remove(at: indexPath.row)
        }
    }
    
    //셀의 갯수 numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return list.count
    }
    
    //셀의 디자인 및 데이터 처리 cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier, for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        
        cell.CheckBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        cell.FavoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
        cell.ContentLabel?.text = list[indexPath.row].Content
        cell.ContentLabel.font = .boldSystemFont(ofSize: 15)
        cell.ContentLabel.textColor = .darkText
        
        return cell
    }
    //셀의 높이 heightForRowAt
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 14
    }

}
