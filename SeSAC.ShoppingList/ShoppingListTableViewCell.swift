//
//  ShoppingListTableViewCell.swift
//  SeSAC.ShoppingList
//
//  Created by Joonhwan Jeon on 2021/10/15.
//

import UIKit   

class ShoppingListTableViewCell: UITableViewCell {
    
    static let identifier = "ShoppingListTableViewCell"

    @IBOutlet weak var CheckBoxButton: UIButton!
    @IBOutlet weak var ContentLabel: UILabel!
    @IBOutlet weak var FavoritesButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
