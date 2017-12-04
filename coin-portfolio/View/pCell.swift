//
//  pCell.swift
//  coin-portfolio
//
//  Created by Nikita on 04/12/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class pCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
