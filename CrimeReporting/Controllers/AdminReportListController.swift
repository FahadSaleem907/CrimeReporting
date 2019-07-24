import Foundation
import UIKit


class AdminReportListController: UIViewController
{

    @IBOutlet weak var reportList: UITableView!
    
    // MARK: - Constants
    // MARK: - Variables
    // MARK: - Outlets
    // MARK: - Actions
    // MARK: - Functions
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        reportList.delegate     = self
        reportList.dataSource   = self
    }

}


extension AdminReportListController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = reportList.dequeueReusableCell(withIdentifier: "cell") as! AdminReportTableViewCell
//
//        if userReports[indexPath.row]?.isPending == true
//        {
//            cell.backgroundColor = .yellow
//        }
//        else if userReports[indexPath.row]?.isInProgress == true
//        {
//            cell.backgroundColor = .orange
//        }
//        else if userReports[indexPath.row]?.isCompleted == true
//        {
//            cell.backgroundColor = .green
//        }
//        cell.reportID.text = userReports[indexPath.row]?.reportType
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = reportList.cellForRow(at: indexPath) as! AdminReportTableViewCell
        
        cell.reportDetails.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        let cell = reportList.cellForRow(at: indexPath) as! AdminReportTableViewCell
        
        cell.reportDetails.isHidden = true
    }
}
