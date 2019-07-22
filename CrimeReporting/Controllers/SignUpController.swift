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
        
        createuser()
//        userServices.createUser(user: user1)
//
//        {
//            (mainError, user, success, error)  in
//            guard let mainError = mainError else { return }
//            guard let success = success else { return }
//            guard let error = error else { return }
//            guard let user = user else { return }
//            let newUser = user
//
//            print("\(mainError) $$$$$$")
//            print("\(error) =======")
//            if success == true
//            {
//                print("\(newUser)")
//                print("created")
//            }
//
//            if success == false
//            {
//                if mainError != nil
//                {
//                    print("Main Error: \(mainError)")
//                }
//                else
//                {
//                    print("Error: \(error)")
//                }
//            }
//        }
    }
        
        
    //Marks : Variables
    
    
    //Marks : Constants
    let userServices = userFunctions()
    
    // MARKS : FUNCTIONS
    
    func createuser()
    {
        let user1 = User(uid: nil, name: "\(name.text!)", email: "\(email.text!)", pw: "\(password.text!)", userType: "\(accountType.text!)", image: nil, userStatus: "Inactive", reportID: [])
        
        
        userServices.createUser(user: user1) { (authError, user, success, dataError) in
            
            guard let authError = authError else { return }
            guard let user = user else { return }
            guard let success = success else { return }
            guard let dataError = dataError else { return }
            
            let newUser = user
            
            print("\(authError) .....")
            print("\(dataError) -----")
            print(user)
            
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
