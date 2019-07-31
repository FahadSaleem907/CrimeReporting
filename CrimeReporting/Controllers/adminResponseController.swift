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
    var tmpReportStatus:String?
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
        if tmpReportStatus == "pending"
        {
            statusAlert(title: "Change Status", msg: "Do You Want To Change Report Status to \"In Process\"", controller: self)
        }
        else if tmpReportStatus == "inProcess"
        {
            statusAlert(title: "Change Status", msg: "Do You Want To Change Report Status to \"Completed\" ? ", controller: self)
        }
        else
        {
            successBtnOut.setTitle("Start", for: .normal)
            successBtnOut.isEnabled = false
        }
    }
    
    
    // MARK: - Functions
    
    func setButtonStates()
    {
        if tmpReportStatus == "pending"
        {
            successBtnOut.setTitle("Start", for: .normal)
            successBtnOut.isEnabled = true
        }
        else if tmpReportStatus == "inProcess"
        {
            successBtnOut.setTitle("Complete", for: .normal)
            successBtnOut.isEnabled = true
        }
        else
        {
            successBtnOut.setTitle("Start", for: .normal)
            successBtnOut.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        setButtonStates()
    }
    
    override func viewDidLayoutSubviews()
    {
        let height2 = successBtnOut.frame.height
        successBtnOut.layer.cornerRadius = height2/2
        successBtnOut.layer.borderWidth = 2
        
        let height1 = failureBtnOut.frame.height
        failureBtnOut.layer.cornerRadius = height1/2
        failureBtnOut.layer.borderWidth = 2
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

//        let height1 = failureBtnOut.frame.height
//        failureBtnOut.layer.cornerRadius = height1/2
//        failureBtnOut.layer.borderWidth = 2
        //failureBtnOut.layer.borderColor = (UIColor.black as! CGColor)
        failureBtnOut.isEnabled = false
        
//        let height2 = successBtnOut.frame.height
//        successBtnOut.layer.cornerRadius = height2/2
//        successBtnOut.layer.borderWidth = 2
        //successBtnOut.layer.borderColor = (UIColor.black as! CGColor)
        successBtnOut.isEnabled = false
        
        print(tmpReportID!)
        print(tmpReportStatus!)
        // Do any additional setup after loading the view.
    }
}

extension adminResponseController
{
    func statusAlert(title:String, msg:String, controller:UIViewController)
    {
        let alertValidation = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let buttonYes = UIAlertAction(title: "Yes", style: .default, handler:
        { _ in
            if self.tmpReportStatus == "pending"
            {
                self.reportServices.pendingReportStatus(reportID: self.tmpReportID!, value: true)
                self.dismiss(animated: true, completion: nil)
            }
            else if self.tmpReportStatus == "inProcess"
            {
                self.reportServices.inProcessReportStatus(reportID: self.tmpReportID!, value: true)
                self.dismiss(animated: true, completion: nil)
            }
            else
            {
                //self.reportServices.completedReportStatus(reportID: self.tmpReportID!, value: true)
            }
            
        })
        
        let buttonNo = UIAlertAction(title: "No", style: .default, handler: nil)
        
        alertValidation.addAction(buttonNo)
        alertValidation.addAction(buttonYes)
        present(alertValidation, animated: true, completion: nil)
    }
}
