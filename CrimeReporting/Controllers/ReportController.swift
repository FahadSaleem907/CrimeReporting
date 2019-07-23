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
    
    let cityPickerView = UIPickerView()
    let reportTypePickerView = UIPickerView()
    let datePicker = UIDatePicker()
    
    let reportServices = reportFunctions()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    //Marks : Outlets
    @IBOutlet weak var city: MDCTextField!
    @IBOutlet weak var reportType: MDCTextField!
    @IBOutlet weak var time: MDCTextField!
    
    @IBOutlet weak var reportDesc: MDCIntrinsicHeightTextView!
    
    //Marks : Actions

    //Marks : Functions
    
    @IBAction func createReport(_ sender: UIButton)
    {
        let tmpReport = Report(city: "\(city.text!)", descField: "\(reportDesc.text!)", reportType: "\(reportType.text!)", userID: (delegate.currentUser?.uid!)!, time: "\(time.text!)", img: nil, pending: true, inProgress: false, completed: false)
        
        reportServices.createReport(reports: tmpReport)
        {
            (report, success, error) in
            
            if let error = error
            {
                print("Not Created. Error: \(error)")
            }
            else
            {
                guard let report = report else { return }
                guard let success = success else { return }
                
                if success == true
                {
                    let newReport = report
                    
                    print("\(newReport)")
                    print("Report Created")
                }
            }
            
        }
    }
    
    override func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        city.inputView = cityPickerView
        reportType.inputView = reportTypePickerView
        
        city.delegate                   = self
        cityPickerView.delegate         = self
        
        reportType.delegate             = self
        reportTypePickerView.delegate   = self
        
        showDatePicker()
        createDateViewToolbar()
        Toolbar()
        // Do any additional setup after loading the view.
    }
}

extension ReportController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == cityPickerView
        {
            return cities.count
        }
        else
        {
            return reportTypes.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == cityPickerView
        {
            return cities[row]
        }
        else
        {
            return reportTypes[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == cityPickerView
        {
            city.text = String(cities[row])
            let acc = cities[row]
            print("zzzzz\(acc)zzzz")
        }
        else
        {
            reportType.text = String(reportTypes[row])
            let acc = reportTypes[row]
            print("zzzzz\(acc)zzzz")
        }
    }
    //
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        var label:UILabel
        
        if let view = view as? UILabel
        {
            label = view
        }
        else
        {
            label = UILabel()
        }
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Menlo-Regular", size: 20)
        
        if pickerView == cityPickerView
        {
            label.text = cities[row]
        }
        else
        {
            label.text = reportTypes[row]
        }
        
        return label
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == city
        {
            return false
        }
        else if textField == reportType
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    @objc private func typeSelected()
    {
        self.view.endEditing(true)
    }
    
    func Toolbar()
    {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(typeSelected))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.barTintColor = .black
        
        city.inputAccessoryView         = toolBar
        reportType.inputAccessoryView   = toolBar
    }
    
}

extension ReportController
{
    private func showDatePicker()
    {
        datePicker.datePickerMode = .date
        time.inputView = datePicker
    }
    
    
    
    @objc private func dateSelected()
    {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy HH:MM:SS"
        //dateFormat.dateFormat = "E, dd MM yyyy HH:MM:SS Z"
        dateFormat.timeZone = TimeZone(secondsFromGMT: 0)!
        time.text = dateFormat.string(from: datePicker.date)
        print(time.text!)
        self.view.endEditing(true)
    }
    
    func createDateViewToolbar()
    {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dateSelected))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.barTintColor = .black
        
        time.inputAccessoryView = toolBar
    }
    
}
