//
//  LegueTableViewCell.swift
//  SportsApp
//
//  Created by Mac on 30/05/2023.
//

import UIKit

class LegueTableViewCell: UITableViewCell {

   
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
