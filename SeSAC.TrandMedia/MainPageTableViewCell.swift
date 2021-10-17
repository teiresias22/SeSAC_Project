//
//  MainPageTableViewCell.swift
//  SeSAC.TrandMedia
//
//  Created by Joonhwan Jeon on 2021/10/17.
//

import UIKit

class MainPageTableViewCell: UITableViewCell {

    static let identifier = "MainPageCell"
    
    @IBOutlet weak var lbMediaTag: UILabel!
    @IBOutlet weak var lbMediaTitleEng: UILabel!
    @IBOutlet weak var imgMediaImage: UIImageView!
    @IBOutlet weak var lbMediaRating: UILabel!
    @IBOutlet weak var lbMediaTitleKr: UILabel!
    @IBOutlet weak var lbMediaOpeningDate: UILabel!
    @IBOutlet weak var mediaView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
