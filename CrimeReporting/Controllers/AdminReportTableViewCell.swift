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
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var staticNameLbl: UILabel!
    @IBOutlet weak var staticCityLbl: UILabel!
    @IBOutlet weak var staticTypeLbl: UILabel!
    @IBOutlet weak var staticDetailsLbl: UILabel!
    
    @IBOutlet weak var animateImg: UIImageView!
    
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
