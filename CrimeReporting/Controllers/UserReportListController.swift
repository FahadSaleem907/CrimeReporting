import Foundation
import UIKit

class UserReportListController: UIViewController
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
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var reportList: UITableView!
    @IBOutlet weak var msgLbl: UILabel!
    
    
    // MARK: - Actions
    
    @IBAction func filter(_ sender: UIBarButtonItem)
    {
        filterCount = filterCount + 1
        
        applyFilter()
    }
    
    
    // MARK: - Functions
    
    func applyFilter()
    {
        if filterCount == 0
        {
            userReports = delegate.currentUser!.reports
            print(userReports.count)
        }
        else if filterCount == 1
        {
            userReports.removeAll()
            for j in delegate.currentUser!.reports
            {
                if j?.isPending == true
                {
                    userReports.append(j)
                }
            }
            //reportList.reloadData()
            print(userReports.count)
        }
        else if filterCount == 2
        {
            userReports.removeAll()
            for j in delegate.currentUser!.reports
            {
                if j?.isInProgress == true
                {
                    userReports.append(j)
                }
            }
            //reportList.reloadData()
            print(userReports.count)
        }
        else
        {
            if filterCount == 3
            {
                userReports.removeAll()
                for j in delegate.currentUser!.reports
                {
                    if j?.isCompleted == true
                    {
                        userReports.append(j)
                    }
                }
                filterCount = filterCount - 4
            }
            //reportList.reloadData()
            print(userReports.count)
        }
    }
    
    func checkReport()
    {
        if userReports.count == 0
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
        reportServices.viewUserReports
            {
                (report) in
                
                self.delegate.currentUser!.reports.removeAll()
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
        
        //checkReport()
        
        //userReports = delegate.currentUser!.reports
    }

}

extension UserReportListController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return userReports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = reportList.dequeueReusableCell(withIdentifier: "cell") as! reportTableViewCell
        
        if userReports[indexPath.row]?.isPending == true
        {
            cell.backgroundColor = .yellow
        }
        else if userReports[indexPath.row]?.isInProgress == true
        {
            cell.backgroundColor = .orange
        }
        else if userReports[indexPath.row]?.isCompleted == true
        {
            cell.backgroundColor = .green
        }
        cell.layer.cornerRadius = 10
        cell.reportID.text = userReports[indexPath.row]?.reportType
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = reportList.cellForRow(at: indexPath) as! reportTableViewCell
        
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
        cell.reportDetails.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        let cell = reportList.cellForRow(at: indexPath) as! reportTableViewCell
        
        cell.reportDetails.isHidden = true
    }
}
