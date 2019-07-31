//
//  adminResponseController.swift
//  CrimeReporting
//
//  Created by Fahad Saleem on 7/30/19.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import UIKit

class adminResponseController: UIViewController {

    // MARK: - Constants
    
    // MARK: - Variables
    
    // MARK: - Outlets
    @IBOutlet weak var failureBtnOut: UIButton!
    @IBOutlet weak var successBtnOut: UIButton!
    
    
    // MARK: - Actions
    @IBAction func backgroundBtn(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewBackground(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Functions
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let height1 = failureBtnOut.frame.height
        failureBtnOut.layer.cornerRadius = height1/2
        failureBtnOut.layer.borderWidth = 2
        //failureBtnOut.layer.borderColor = (UIColor.black as! CGColor)
        
        let height2 = successBtnOut.frame.height
        successBtnOut.layer.cornerRadius = height2/2
        successBtnOut.layer.borderWidth = 2
        //successBtnOut.layer.borderColor = (UIColor.black as! CGColor)
        
        // Do any additional setup after loading the view.
    }
}
