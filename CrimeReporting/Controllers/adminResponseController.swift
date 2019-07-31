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
    let reportServices = reportFunctions()
    
    // MARK: - Variables
    var reportID:String?
    var tmpReportID:String?
    
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
    
    @IBAction func startProcessing(_ sender: UIButton)
    {
        
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

extension adminResponseController
{
//    func statusAlert(title:String, msg:String, controller:UIViewController)
//    {
//        let alertValidation = UIAlertController(title: title, message: msg, preferredStyle: .alert)
//        let buttonOK = UIAlertAction(title: "Yes", style: .default, handler: {_ in
//           
//           reportServices.inProcessReportStatus(reportID: , value: <#T##Bool#>) self.navigationController?.popViewController(animated: true) })
//        let buttonNo = UIAlertAction(title: "No", style: .default, handler: nil)
//        alertValidation.addAction(buttonOK)
//        present(alertValidation, animated: true, completion: nil)
//    }
}
