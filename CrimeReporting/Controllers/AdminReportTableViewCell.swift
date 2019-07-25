import Foundation
import UIKit

class AdminReportTableViewCell: UITableViewCell
{

    // MARK: - Constants
    // MARK: - Variables
    // MARK: - Actions
    // MARK: - Functions
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        //reportDetails.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
