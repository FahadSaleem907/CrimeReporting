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

    //Mark: Variables
    
    //Mark: Outlets
    @IBOutlet weak var emaill: UITextField!
    @IBOutlet weak var pw: UITextField!
    
    //Mark: Actions
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotPwBtn: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

