//
//  fancyUIButton.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 16/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import Foundation
import UIKit

class fancyUIButton1 : UIButton
{
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        fancyButton1()
    }
    
    func fancyButton1()
    {
        self.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        //self.layer.borderWidth = 0.5
        //self.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let height = self.layer.frame.height
        self.layer.cornerRadius =  height / 5
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.gray, for: .disabled)
        self.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .allowUserInteraction, animations:
            {
                self.transform = CGAffineTransform.identity
        }, completion: nil)
        
        super.touchesBegan(touches, with: event)
    }
    
}
