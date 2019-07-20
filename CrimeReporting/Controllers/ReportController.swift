//
//  ReportController.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 20/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextFields


class ReportController: UIViewController {

    //Marks : Variables
    
    
    //Marks : Constants
    let reportTypes = ["Kidnapping","Homicide","Mugging","Assault And Batter","Sexual Assault","Hit and Run", "Breaking and Entering", "Destruction of Public Property","Embezzlement", "Forgery"]
    
    let cities = ["Karachi","Lahore","Islamabad","Faisalabad","Hyderabad","Peshawar","Murree"]
    
    let reportServices = reportFunctions()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    //Marks : Outlets
    @IBOutlet weak var city: MDCTextField!
    @IBOutlet weak var reportType: MDCTextField!
    @IBOutlet weak var time: MDCTextField!
    
    //Marks : Actions

    //Marks : Functions
    
    @IBAction func createReport(_ sender: UIButton)
    {
        let tmpReport = Report(city: "\(city.text!)", descField: "testing", reportType: "\(reportType.text!)", user: nil, time: "\(time.text!)", img: nil)
        
        reportServices.createReport(reports: tmpReport)
        {
            (report, success, error) in
            
            guard let report = report else { return }
            guard let success = success else { return }
            guard let error = error else { return }
            let newReport = report
            
            if success == true
            {
                print("\(newReport)")
                print("Report Created")
            }
            else
            {
                print("Not Created. Error: \(error)")
            }
        }
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
