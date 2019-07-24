import Foundation
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
        if delegate.currentUser?.reports.count == 0
        {
            lastReportLbl.text = "No Reports Filed"
        }
        else
        {
            let count = delegate.currentUser!.reports.count - 1
            lastReportLbl.text = delegate.currentUser?.reports[count]?.time
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        nameLbl.text    =   delegate.currentUser?.name
        emailLbl.text   =   delegate.currentUser?.email
        reportCountLbl.text = String(delegate.currentUser!.reports.count)
        
        checkReports()
    }
    
}
