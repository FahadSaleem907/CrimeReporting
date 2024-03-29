import Foundation
import UIKit
import MaterialComponents.MaterialTextFields


class ReportController: UIViewController {

    //Marks : Variables
    //var reportsList = [Report?]()
    
    //Marks : Constants
    //let reportTypes = ["Kidnapping","Homicide","Mugging","Assault And Batter","Sexual Assault","Hit and Run", "Breaking and Entering", "Destruction of Public Property","Embezzlement", "Forgery"]
    
    let cityPickerView = UIPickerView()
    let reportTypePickerView = UIPickerView()
    let datePicker = UIDatePicker()
    
    let reportServices = reportFunctions()
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    //Marks : Outlets
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var reportType: UITextField!
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var reportDesc: MDCIntrinsicHeightTextView!
    
    //Marks : Actions
    
    @IBAction func createReport(_ sender: UIButton)
    {
        if city.text?.isEmpty == true
        {
            alert(msg: "Enter City.", controller: self, textField: city)
        }
        else if reportType.text?.isEmpty == true
        {
            alert(msg: "Enter Report Type.", controller: self, textField: reportType)
        }
        else if time.text?.isEmpty == true
        {
            alert(msg: "Enter Time.", controller: self, textField: time)
        }
        else if reportDesc.text.isEmpty == true
        {
            alert1(msg: "Enter Report Details.", controller: self, textView: reportDesc)
        }
        else
        {
            let tmpReport = Report(reportID: "id", city: "\(city.text!)", descField: "\(reportDesc.text!)", reportType: "\(reportType.text!)", userID: (delegate.currentUser?.uid!)!, time: "\(time.text!)", img: nil, pending: true, inProgress: false, completed: false, userName: delegate.currentUser!.name)
        
            reportServices.createReport(reports: tmpReport)
            {
                (report, success, error) in
            
                if let error = error
                {
                    self.statusAlert(title: "Error", msg: "\(error)", controller: self)
                }
                else
                {
                    guard let report = report else { return }
                    guard let success = success else { return }
                
                    if success == true
                    {
                        let newReport = report
                    
                        self.statusAlert(title: "Success", msg: "Report Created Successfully.\n\(newReport)", controller: self)
                    }
                }
            
            }
        }
    }
    
    //Marks : Functions
    
    override func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        city.inputView = cityPickerView
        city.textColor = .init(red: 192, green: 192, blue: 192, alpha: 1)
        city.backgroundColor = .clear
        reportType.textColor = .init(red: 192, green: 192, blue: 192, alpha: 1)
        reportType.backgroundColor = .clear
        time.textColor = .init(red: 192, green: 192, blue: 192, alpha: 1)
        time.backgroundColor = .clear
        reportDesc.textColor = .init(red: 192, green: 192, blue: 192, alpha: 1)
        reportDesc.backgroundColor = .clear
        reportType.inputView = reportTypePickerView
        
        city.keyboardAppearance         = .dark
        reportType.keyboardAppearance   = .dark
        time.keyboardAppearance         = .dark
        
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
            return reportServices.cities.count
        }
        else
        {
            return reportServices.reportTypes.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == cityPickerView
        {
            return reportServices.cities[row]
        }
        else
        {
            return reportServices.reportTypes[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == cityPickerView
        {
            city.text = String(reportServices.cities[row])
            let acc = reportServices.cities[row]
            print("zzzzz\(acc)zzzz")
        }
        else
        {
            reportType.text = String(reportServices.reportTypes[row])
            let acc = reportServices.reportTypes[row]
            print("zzzzz\(acc)zzzz")
        }
    }
    
    
    
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
            label.text = reportServices.cities[row]
        }
        else
        {
            label.text = reportServices.reportTypes[row]
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

extension ReportController
{
    func alert(msg:String , controller:UIViewController, textField:UITextField)
    {
        let alertValidation = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let buttonOK = UIAlertAction(title: "Okay", style: .default)
        {
            (_) in textField.becomeFirstResponder()
        }
        alertValidation.addAction(buttonOK)
        present(alertValidation, animated: true, completion: nil)
    }
    
    func alert1(msg:String , controller:UIViewController, textView:UITextView)
    {
        let alertValidation = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let buttonOK = UIAlertAction(title: "Okay", style: .default)
        {
            (_) in textView.becomeFirstResponder()
        }
        alertValidation.addAction(buttonOK)
        present(alertValidation, animated: true, completion: nil)
    }
    
    func statusAlert(title:String, msg:String, controller:UIViewController)
    {
        let alertValidation = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let buttonOK = UIAlertAction(title: "Okay", style: .default, handler: {_ in
            //self.getData()
            self.navigationController?.popViewController(animated: true) })
        alertValidation.addAction(buttonOK)
        present(alertValidation, animated: true, completion: nil)
    }
}
