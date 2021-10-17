//
//  CastListTableViewCell.swift
//  SeSAC.TrandMedia
//
//  Created by Joonhwan Jeon on 2021/10/17.
//

import UIKit

class CastListTableViewCell: UITableViewCell {
    
    static let identifier = "CastListCell"

    @IBOutlet weak var imgActorImage: UIImageView!
    @IBOutlet weak var lbActorName: UILabel!
    @IBOutlet weak var lbCastName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
