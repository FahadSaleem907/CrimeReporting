import UIKit

class ProfileController: UIViewController {

    // Marks : Constants
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    // Marks : Outlets
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var reportCountLbl: UILabel!
    @IBOutlet weak var lastReportLbl: UILabel!
    
    func checkReports()
    {
        if delegate.currentUser?.reportsID.count == 0
        {
            lastReportLbl.text = "No Reports Filed"
        }
        else
        {
            delegate.currentUser?.reportsID.last
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        nameLbl.text    =   delegate.currentUser?.name
        emailLbl.text   =   delegate.currentUser?.email
    }
    
}
