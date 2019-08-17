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
            self.userReports.sort { (a, b) -> Bool in
                let isoDateA = a?.time
                let isoDateB = b?.time
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy HH:MM:SS"
                let dateA = dateFormatter.date(from: isoDateA!)
                let dateB = dateFormatter.date(from: isoDateB!)
                
                return dateA! > dateB!
            }
            reportList.reloadData()
        }
    }
    var filterCount = 0
    var reportsList = [Report?]()
    var isCellTapped = false
    var selectedIndex = 0
    var hiddensCell = [Int]()
    var tmpReportID:String?
    var tmpReportStatus:String?
    
    // MARK: - Outlets
    @IBOutlet weak var reportList: UITableView!
    @IBOutlet weak var msgLbl: UILabel!
    
    // MARK: - Actions
    @IBAction func applyFilter(_ sender: UIBarButtonItem)
    {
        getFilterSheet1(title: "Filter By", msg: "---------")
    }
    
    @IBAction func cityFilter(_ sender: UIBarButtonItem)
    {
        getFilterSheet2(title: "Filter By", msg: "---------")
    }
    
    
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
                self.reportsList = report
                
                self.delegate.currentUser?.reports = self.reportsList
                completion(self.delegate.currentUser!.reports)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        getData { (report) in
            self.userReports.removeAll()
            self.userReports = report
            self.checkReport()
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        reportList.delegate     = self
        reportList.dataSource   = self
        
        checkReport()
    }

    // MARK: -Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let passReportID = segue.destination as! adminResponseController
        passReportID.tmpReportID = tmpReportID
        passReportID.tmpReportStatus = tmpReportStatus
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
        
        func emptyCell()
        {
            cell.actBtn.isHidden = true
            
            //cell.cityLbl.isHidden = true
            //cell.staticCityLbl.isHidden = true
            
            cell.typeLbl.isHidden = true
            cell.staticTypeLbl.isHidden = true
            
            cell.descriptionLbl.isHidden = true
            cell.staticDetailsLbl.isHidden = true
            
            cell.animateImg.image = UIImage.init(named: "expand")
        }
        
        func refillCell()
        {
            cell.actBtn.isHidden = false
            
            //cell.cityLbl.isHidden = false
            //cell.staticCityLbl.isHidden = false
            
            cell.typeLbl.isHidden = false
            cell.staticTypeLbl.isHidden = false
            
            cell.descriptionLbl.isHidden = false
            cell.staticDetailsLbl.isHidden = false
            
            cell.animateImg.image = UIImage.init(named: "expand")
        }
        
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
        
        
        if !self.hiddensCell.contains(indexPath.row)
        {
            reportList.beginUpdates()
            
            emptyCell()
            
            //cell.staticNameLbl.text = "Report ID:"
            //cell.nameLbl.text = userReports[indexPath.row]?.reportID
            cell.nameLbl.text = userReports[indexPath.row]?.userName
            cell.cityLbl.text = userReports[indexPath.row]?.city
            
            reportList.endUpdates()
        }
        else
        {
            reportList.beginUpdates()
            
            refillCell()
            
            //cell.staticNameLbl.text = "Name: "
            cell.actBtn.layer.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0, blue: 1, alpha: 1)
            cell.nameLbl.text = userReports[indexPath.row]?.userName
            //cell.cityLbl.text = userReports[indexPath.row]?.city
            cell.typeLbl.text = userReports[indexPath.row]?.reportType
            cell.descriptionLbl.text = userReports[indexPath.row]?.descriptionField
            cell.animateImg.image = UIImage.init(named: "collapse")
            reportList.endUpdates()
        }
        
        cell.backgroundColor = .clear
        cell.cellBackgroundView.layer.cornerRadius = 10
        return cell
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if hiddensCell.last == indexPath.row
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
        
        selectedIndex = indexPath.row
        
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
        
        func animate(cell: AdminReportTableViewCell)
        {
            UIView.animate(withDuration: 0.5)
            {
                
            if !self.hiddensCell.contains(indexPath.row)
            {
                print(self.hiddensCell)
                self.hiddensCell.removeAll()
                self.hiddensCell.append(indexPath.row)
            }
            else
            {
//                if let index = self.hiddensCell.firstIndex(of: indexPath.row)
//                {
//                    self.hiddensCell.remove(at: index)
//                }

                self.hiddensCell.removeLast()
                print(self.hiddensCell)
                
//                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            }
        }
        
        self.tmpReportID = userReports[indexPath.row]?.reportID
        
        if userReports[indexPath.row]?.isPending == true
        {
            self.tmpReportStatus = "pending"
        }
        else if userReports[indexPath.row]?.isCompleted == true
        {
            self.tmpReportStatus = "completed"
        }
        else
        {
            self.tmpReportStatus = "inProcess"
        }
        animate(cell: cell)
        self.reportList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
//            hiddensCell.removeLast()
    }
    
    
}


extension AdminReportListController
{
    func getFilterSheet1(title:String, msg:String)
    {
        let filterOptions = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        
        let filterByPendingAction = UIAlertAction(title: "Pending", style: .default)
        {
            (_) in
            
            self.getData
                {
                    (report) in
                    
                    self.userReports.removeAll()
                    self.userReports = report
                    self.checkReport()
                    
                    self.userReports.removeAll()
                    for j in self.delegate.currentUser!.reports
                    {
                        if j?.isPending == true
                        {
                            self.userReports.append(j)
                        }
                    }
            }
            
            
            print(self.userReports.count)
        }
        
        let filterByInProcessAction = UIAlertAction(title: "In Process", style: .default)
        {
            (_) in
            
            self.getData
                {
                    (report) in

                    self.userReports.removeAll()
                    self.userReports = report
                    self.checkReport()
                    
                    self.userReports.removeAll()
                    for j in self.delegate.currentUser!.reports
                    {
                        if j?.isInProgress == true
                        {
                            self.userReports.append(j)
                        }
                    }
            }
            
            print(self.userReports.count)
        }
        
        let filterByCompletedAction = UIAlertAction(title: "Completed", style: .default)
        {
            (_) in
            
            self.getData
                {
                    (report) in

                    self.userReports.removeAll()
                    self.userReports = report
                    self.checkReport()
                    
                    self.userReports.removeAll()
                    for j in self.delegate.currentUser!.reports
                    {
                        if j?.isCompleted == true
                        {
                            self.userReports.append(j)
                        }
                    }
            }
            
        }
        
        filterOptions.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:
            {
                (action) in
                
                action.setValue(UIColor.red, forKey: "titleTextColor")
                
                self.userReports = self.delegate.currentUser!.reports
                print(self.userReports.count)
        }))
        
        
        filterOptions.addAction(filterByPendingAction)
        filterOptions.addAction(filterByInProcessAction)
        filterOptions.addAction(filterByCompletedAction)
        
        self.present(filterOptions, animated: true, completion: nil)
    }
    
    func getFilterSheet2(title:String, msg:String)
    {
        let filterOptions = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        
        for i in reportServices.cities
        {
            let i = UIAlertAction(title: "\(i)", style: .default)
            {
                (_) in
                func getFilterData(completion:@escaping([Report?])->Void)
                {
                    self.reportServices.filterReports(filterType: "\(i)", completion:
                        {
                            (report) in
                    
                            self.delegate.currentUser!.reports.removeAll()
                            self.reportsList = report
                        
                            self.delegate.currentUser?.reports = self.reportsList
                            completion(self.delegate.currentUser!.reports)
                        })
                
                    print("City")
                }
                getFilterData(completion:
                    {
                        (report) in
                        self.userReports.removeAll()
                        self.userReports = report
                        self.checkReport()
                    }       )
                self.reportList.reloadData()
            }
            filterOptions.addAction(i)
        }
        
        filterOptions.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:
            {
                (action) in
            
                action.setValue(UIColor.red, forKey: "titleTextColor")
                
                self.getData(completion:
                {
                    (report) in
                    self.userReports.removeAll()
                    self.userReports = report
                    self.checkReport()
                })
        }))
        
        self.present(filterOptions, animated: true, completion: nil)
    }
}
