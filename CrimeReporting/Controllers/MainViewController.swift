//
//  ViewController.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 16/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {

    // Mark: - Variables
    
    // Mark: - Outlets
    @IBOutlet weak var emaill: UITextField!
    @IBOutlet weak var pw: UITextField!
    
    //Mark: - Actions
  
    @IBAction func login(_ sender: fancyUIButton1)
    {
        let userServices = userFunctions()
        
        userServices.login(email: emaill.text!, password: pw.text!) { (user, success, error) in
            guard let user = user else { return }
            guard let success = success else { return }
            guard let error = error else { return }
            
            if success == true
            {
                print("Success. User : \(user)")
            }
            else
            {
                print("Failed. Error : \(error)")
            }
        }
    }
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotPwBtn: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        emaill.text = "fahad@fahad.com"
        pw.text = "123123"
    }
}

