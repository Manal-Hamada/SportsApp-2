//
//  LeguesableViewCell.swift
//  SportsApp
//
//  Created by Mac on 19/05/2023.
//

import UIKit

class LeguesableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!    
    @IBOutlet weak var videoImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        // Configure the view for the selected state
    }

}
