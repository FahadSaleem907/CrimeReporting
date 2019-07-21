//
//  reportTableViewCell.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 21/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import UIKit

class reportTableViewCell: UITableViewCell
{

    
    @IBOutlet weak var reportID: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
