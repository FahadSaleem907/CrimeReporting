import Foundation
import UIKit

class reportTableViewCell: UITableViewCell
{

    @IBOutlet weak var reportID: UILabel!
    @IBOutlet weak var reportDetails: UIButton!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        reportDetails.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
