//
//  SearchTableViewCell.swift
//  SeSAC.TrandMedia
//
//  Created by Joonhwan Jeon on 2021/10/17.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchCell"

    @IBOutlet weak var imgMediaPoster: UIImageView!
    @IBOutlet weak var lbSearchMediaTitle: UILabel!
    @IBOutlet weak var lbSearchMediaSubTitle: UILabel!
    @IBOutlet weak var lbSearchMediaSynopsis: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
