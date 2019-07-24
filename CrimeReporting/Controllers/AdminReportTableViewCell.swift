import Foundation
import UIKit

class AdminReportTableViewCell: UITableViewCell
{

    // MARK: - Constants
    // MARK: - Variables
    // MARK: - Outlets
    // MARK: - Actions
    // MARK: - Functions
    
    @IBOutlet weak var reportID: UILabel!
    @IBOutlet weak var reportDetails: UIButton!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        reportDetails.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
