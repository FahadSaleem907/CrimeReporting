import Foundation
import UIKit


class AdminReportListController: UIViewController
{
    // MARK: - Constants
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let reportServices = reportFunctions()
    
    
    // MARK: - Variables
    var userReports = [Report?]()
    {
        didSet
        {
            reportList.reloadData()
        }
    }
    var filterCount = 0
    var reportsList = [Report?]()
    var isCellTapped = false
    var selectedIndex = 0
    
    
    // MARK: - Outlets
    @IBOutlet weak var reportList: UITableView!
    @IBOutlet weak var msgLbl: UILabel!
    
    // MARK: - Actions
    
    
    // MARK: - Functions
    func checkReport()
    {
        if delegate.currentUser?.reports.count == 0
        {
            reportList.isHidden = true
            msgLbl.isHidden = false
        }
        else
        {
            reportList.isHidden = false
            msgLbl.isHidden = true
        }
    }
    
    func getData(completion:@escaping([Report?])->Void)
    {
        reportServices.adminViewReports
            {
                (report) in
            
                self.delegate.currentUser!.reports.removeAll()
                //self.reportsList.removeAll()
                self.reportsList = report
                
                self.delegate.currentUser?.reports = self.reportsList
                completion(self.delegate.currentUser!.reports)
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        getData { (report) in
            self.userReports.removeAll()
            self.userReports = report
            self.checkReport()
        }
        
        //userReports = delegate.currentUser!.reports
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        reportList.delegate     = self
        reportList.dataSource   = self
        
        checkReport()
    }

}


extension AdminReportListController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return userReports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = reportList.dequeueReusableCell(withIdentifier: "cell") as! AdminReportTableViewCell

        
        
            if userReports[indexPath.row]?.isPending == true
            {
                cell.cellBackgroundView.backgroundColor = .yellow
            }
            else if userReports[indexPath.row]?.isInProgress == true
            {
                cell.cellBackgroundView.backgroundColor = .orange
            }
            else if userReports[indexPath.row]?.isCompleted == true
            {
                cell.cellBackgroundView.backgroundColor = .green
            }
        
            cell.nameLbl.text = userReports[indexPath.row]?.userName
            cell.cityLbl.text = userReports[indexPath.row]?.city
            cell.typeLbl.text = userReports[indexPath.row]?.reportType
            cell.descriptionLbl.text = userReports[indexPath.row]?.descriptionField
            
            if isCellTapped == false
            {
                cell.staticCityLbl.text         = "ReportID:"
                cell.cityLbl.text               = userReports[indexPath.row]?.reportID
                cell.staticTypeLbl.isHidden     = true
                cell.typeLbl.isHidden           = true
                cell.animateImg.image           = UIImage.init(named: "expand")
                cell.staticNameLbl.isHidden     = true
                cell.nameLbl.isHidden           = true
                cell.staticDetailsLbl.isHidden  = true
                cell.descriptionLbl.isHidden    = true
            }
            else
            {
                cell.cityLbl.text               = userReports[indexPath.row]?.city
                cell.staticCityLbl.text         = "City"
                cell.typeLbl.isHidden           = false
                cell.staticTypeLbl.isHidden     = false
                cell.animateImg.image           = UIImage.init(named: "collapse")
                cell.staticNameLbl.isHidden     = false
                cell.nameLbl.isHidden           = false
                cell.staticDetailsLbl.isHidden  = false
                cell.descriptionLbl.isHidden    = false
            }
        
        cell.backgroundColor = .clear
            cell.cellBackgroundView.layer.cornerRadius = 10
            cell.animateImg.isHidden = false
            return cell
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if isCellTapped == true && selectedIndex == indexPath.row
        {
            return 300
        }
        else
        {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = reportList.cellForRow(at: indexPath) as! AdminReportTableViewCell
        
        if userReports[indexPath.row]?.isPending == true
        {
            let yellowBGColorView = UIView()
            yellowBGColorView.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.2)
            cell.selectedBackgroundView = yellowBGColorView
        }
        else if userReports[indexPath.row]?.isInProgress == true
        {
            let orangeBGColorView = UIView()
            orangeBGColorView.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.2)
            cell.selectedBackgroundView = orangeBGColorView
        }
        else if userReports[indexPath.row]?.isCompleted == true
        {
            let greenBGColorView = UIView()
            greenBGColorView.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.2)
            cell.selectedBackgroundView = greenBGColorView
        }
        
        func animate()
        {
            if isCellTapped == false
            {
                selectedIndex = indexPath.row
                isCellTapped = true
    
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            else
            {
                isCellTapped = false

//                if isCellTapped == false
//                {
//                    cell.staticDetailsLbl.isHidden = true
//                    cell.staticNameLbl.isHidden = true
//                    cell.detailTextLabel?.isHidden = true
//                    cell.nameLbl.isHidden = true
//                }
//                print("For Animate = \(isCellTapped)")
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        animate()
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        let cell = reportList.cellForRow(at: indexPath) as! AdminReportTableViewCell
        isCellTapped = false
    }
}
