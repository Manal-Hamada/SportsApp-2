//
//  TeamTableViewCell.swift
//  SportsApp
//
//  Created by Mac on 31/05/2023.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

   
    

  
    @IBOutlet weak var tshirtNum: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerposition: UILabel!    
    @IBOutlet weak var yelloCard: UILabel!
    @IBOutlet weak var redCard: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
