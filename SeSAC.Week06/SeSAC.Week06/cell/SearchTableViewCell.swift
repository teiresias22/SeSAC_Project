//
//  SearchTableViewCell.swift
//  SeSAC.Week06
//
//  Created by Joonhwan Jeon on 2021/11/02.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var daiaryImageView: UIImageView!
    
    static let identifier = "SearchTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.font = UIFont().mainHeavy
        dateLabel.font = UIFont().mainLight
        dateLabel.textColor = .systemGray
        mainTextLabel.font = UIFont().mainMedium
        mainTextLabel.numberOfLines = 0
        
        daiaryImageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
