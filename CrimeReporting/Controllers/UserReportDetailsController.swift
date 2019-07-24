import Foundation
import UIKit

class UserReportDetailsController: UIViewController
{

    // MARK: - Constants
    // MARK: - Variables
    // MARK: - Outlets
    // MARK: - Actions
    // MARK: - Functions
    
    @IBAction func cover(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if view.tag == 1
        {
            self.view.endEditing(true)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

}
