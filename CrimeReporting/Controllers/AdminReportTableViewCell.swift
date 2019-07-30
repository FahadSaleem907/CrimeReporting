import Foundation
import UIKit

class AdminReportTableViewCell: UITableViewCell
{

    // MARK: - Constants
    // MARK: - Variables
    // MARK: - Actions
    // MARK: - Functions
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var cellBackgroundView: UIView!
    
    @IBOutlet weak var actBtn: fancyUIButton1!
    
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
        actBtn.isHidden = true
        
        cityLbl.isHidden = true
        staticCityLbl.isHidden = true
        
        //nameLbl.isHidden = true
        //staticNameLbl.isHidden = true
        
        typeLbl.isHidden = true
        staticTypeLbl.isHidden = true
        
        descriptionLbl.isHidden = true
        staticDetailsLbl.isHidden = true
        
        animateImg.image = UIImage.init(named: "expand")
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
