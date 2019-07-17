//
//  fancyUITextField.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 16/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import Foundation
import UIKit


class fancyTextField : UITextField
{
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        styleTextField()
    }
    
    func styleTextField()
    {
        let newColor = UIColor.white
        let border = CALayer()
        let width = CGFloat(1.5)
        
        border.borderColor = newColor.cgColor
        border.borderWidth = width
        border.frame = CGRect(x: 0, y: bounds.size.height - width, width: bounds.size.width , height: bounds.size.height)
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

}
