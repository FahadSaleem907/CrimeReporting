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
        if emaill.text?.isEmpty == true
        {
            alert(msg: "Email Missing.\nEnter Email.", controller: self, textField: emaill)
        }
        else if pw.text?.isEmpty == true
        {
            alert(msg: "Password Missing.\nEnter Password.", controller: self, textField: pw)
        }
        else if pw.text!.count <= 5
        {
            alert(msg: "Password is too small", controller: self, textField: pw)
        }
        else
        {
            login()
        }
    }
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotPwBtn: UIButton!
    
    
    func login()
    {
        let userServices = userFunctions()
        
        userServices.login(email: emaill.text!, password: pw.text!)
        {
            (user, success, error) in
            
            if let error = error
            {
                self.statusAlert1(title: "Error", msg: "\(error)", controller: self)
            }
            else
            {
                guard let user = user else { return }
                guard let success = success else { return }
                
                if success == true
                {
                    self.statusAlert(title: "Success", msg: "Logged in Successfully.\nUser: \(user)", controller: self)
                    
                    let reportServices = reportFunctions()
                    //reportServices.viewReports()
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        emaill.text = "fahad@fahad.com"
        pw.text = "123123"
    }
}

extension MainViewController
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
    
    func statusAlert(title:String, msg:String, controller:UIViewController)
    {
        let alertValidation = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let buttonOK = UIAlertAction(title: "Okay", style: .default, handler: {_ in //self.navigationController?.popViewController(animated: true) })
            self.performSegue(withIdentifier: "loginUser", sender: self) })
        alertValidation.addAction(buttonOK)
        present(alertValidation, animated: true, completion: nil)
    }
    
    func statusAlert1(title:String, msg:String, controller:UIViewController)
    {
        let alertValidation = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let buttonOK = UIAlertAction(title: "Okay", style: .default, handler: {_ in //self.navigationController?.popViewController(animated: true) })
            //self.performSegue(withIdentifier: "loginUser", sender: self)
            return
        })
        alertValidation.addAction(buttonOK)
        present(alertValidation, animated: true, completion: nil)
    }
}
