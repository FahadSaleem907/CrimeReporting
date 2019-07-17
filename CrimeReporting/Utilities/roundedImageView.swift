//
//  roundedImageView.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 16/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import Foundation
import UIKit

class roundedImageView : UIImageView
{
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        roundImage()
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        roundImage()
        
    }
    
    
    func roundImage()
    {
        let height = self.frame.height
        self.layer.cornerRadius = height / 2
        self.layer.masksToBounds = true
        self.contentMode = .scaleToFill
    }
}
