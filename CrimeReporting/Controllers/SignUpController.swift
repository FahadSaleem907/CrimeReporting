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
    @IBOutlet weak var uploadImgOutlet: UIButton!
    
    //Marks : Actions
    
    @IBAction func uploadImg(_ sender: UIButton)
    {
        imageAlert()
    }
    
    
    @IBAction func createUser(_ sender: fancyUIButton1)
    {
        if name.text?.isEmpty == true
        {
            alert(msg: "Name Field is Empty.\nEnter Name", controller: self, textField: name)
        }
        else if email.text?.isEmpty == true
        {
            alert(msg: "Email Field is Empty.\nEnter Email", controller: self, textField: email)
        }
        else if password.text?.isEmpty == true
        {
            alert(msg: "Password Field is Empty.\nEnter Password", controller: self, textField: password)
        }
        else if password.text!.count <= 5
        {
            alert(msg: "Small Password.\nPassword Must Have 6 or more characters.", controller: self, textField: password)
        }
        else if accountType.text?.isEmpty == true
        {
            alert(msg: "Account Type Field is Empty.\nEnter Account Type", controller: self, textField: accountType)
        }
        else
        {
            createuser()
        }
    }
        
        
    //Marks : Variables
    
    
    //Marks : Constants
    let userServices = userFunctions()
    let userType = ["Admin","User"]
    let type = UIPickerView()
    
    // MARKS : FUNCTIONS
    
    func createuser()
    {
        let user1 = User(uid: nil, name: "\(name.text!)", email: "\(email.text!)", pw: "\(password.text!)", userType: "\(accountType.text!)", image: nil, userStatus: "Inactive", report: [])
        
        
        userServices.createUser(user: user1)
        {
            (authError, user, success, dataError) in
                if let authError = authError
                {
                    self.statusAlert(title: "Error", msg: "\(authError)", controller: self)
                }
                else
                {
                    if let dataError = dataError
                    {
                        self.statusAlert(title: "Error", msg: "\(dataError)", controller: self)
                    }
                    else
                    {
                        guard let user = user else { return }
                        guard let success = success else { return }
                    
                        let newUser = user
                    
                        if success ==  true
                        {
                            self.statusAlert(title: "Success", msg: "User Created Successfully.\n\(newUser)", controller: self)
                        }
                    
                    }
                }
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews()
    {
        let height = uploadImgOutlet.frame.height
        uploadImgOutlet.layer.cornerRadius = height/2
        uploadImgOutlet.layer.masksToBounds = true
        uploadImgOutlet.contentMode = .scaleToFill
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        accountType.inputView   = type
        accountType.delegate    = self
        type.delegate           = self
        
        accountTypeToolbar()
        
        name.textColor          = .init(red: 192, green: 192, blue: 192, alpha: 1)
        email.textColor         = .init(red: 192, green: 192, blue: 192, alpha: 1)
        password.textColor      = .init(red: 192, green: 192, blue: 192, alpha: 1)
        accountType.textColor   = .init(red: 192, green: 192, blue: 192, alpha: 1)
    }
    
}

// MARK: -Alerts
extension SignUpController
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
        let buttonOK = UIAlertAction(title: "Okay", style: .default, handler: {_ in self.navigationController?.popViewController(animated: true) })
        alertValidation.addAction(buttonOK)
        present(alertValidation, animated: true, completion: nil)
    }
    
    func imageAlert()
    {
        let imgAlert = UIAlertController(title: "", message: "Selection Type", preferredStyle: .actionSheet)
        
        let takePicBtn = UIAlertAction(title: "Camera", style: .default)
        { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
            self.presentPhotoPicker(source: .camera)
            }
            else
            {
                print("Camera Not Available or Accessable")
            }
        }
        
        let choosePicBtn = UIAlertAction(title: "Gallery", style: .default)
        { _ in
            self.presentPhotoPicker(source: .photoLibrary)
        }
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        imgAlert.addAction(takePicBtn)
        imgAlert.addAction(choosePicBtn)
        imgAlert.addAction(cancelBtn)
        
        present(imgAlert, animated: true, completion: nil)
    }
}

// MARK: -PickerViews
extension SignUpController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return userType.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return userType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        accountType.text = String(userType[row])
        let acc = userType[row]
        print("zzzzz\(acc)zzzz")
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
        
        label.text = userType[row]
        
        return label
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == accountType
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
    
    func accountTypeToolbar()
    {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(typeSelected))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.barTintColor = .black
        
        accountType.inputAccessoryView = toolBar
    }
}

extension SignUpController: UIImagePickerControllerDelegate/*, UINavigationControllerDelegate*/
{
    func presentPhotoPicker(source: UIImagePickerController.SourceType)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = source
        present(picker , animated: true , completion: nil)
    }
    
    func getImg()
    {
        guard UIImagePickerController.isSourceTypeAvailable(.camera)
        else
        {
            presentPhotoPicker(source: .photoLibrary)
            return
        }
    }
}
