//
//  SignUpController.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 17/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextFields


class SignUpController: UIViewController
{
    //Marks : Outlets
    @IBOutlet weak var name: MDCTextField!
    @IBOutlet weak var email: MDCTextField!
    @IBOutlet weak var password: MDCTextField!
    @IBOutlet weak var accountType: MDCTextField!
    
    //Marks : Actions
    
    @IBAction func createUser(_ sender: fancyUIButton1)
    {
        let user1 = User(uid: nil, name: "\(name.text!)", email: "\(email.text!)", pw: "\(password.text!)", userType: "\(accountType.text!)", image: nil, userStatus: false)
        
        userServices.createUser(user: user1)
        { (user, success, error) in
            
            guard let success = success else { return }
            guard let error = error else { return }
            guard let user = user else { return }
            let newUser = user
            
            if success == true
            {
                print("\(newUser)")
                print("created")
            }
            else
            {
                print("Error: \(error)")
            }
        }
    }
    //Marks : Variables
    
    
    //Marks : Constants
    let userServices = userFunctions()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
