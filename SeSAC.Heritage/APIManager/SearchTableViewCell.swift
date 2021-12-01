//
//  SearchTableViewCell.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/11/30.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"

    @IBOutlet weak var searchCellView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        searchCellView.backgroundColor = .customYellow
        searchCellView.layer.cornerRadius = 8
        
        countLabel.textColor = .customBlack
        countLabel.textAlignment = .center
        countLabel.font = UIFont(name: "MapoFlowerIsland", size: 32)!
        
        titleLabel.textColor = .customBlack
        titleLabel.font = UIFont().MapoFlowerIsland16
        
        cityLabel.textColor = .customBlack
        cityLabel.font = UIFont().MapoFlowerIsland14
        
        locationLabel.textColor = .customBlack
        locationLabel.font = UIFont().MapoFlowerIsland14
        
        categoryLabel.textColor = .customBlack
        categoryLabel.font = UIFont().MapoFlowerIsland14
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
