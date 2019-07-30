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
    var hiddensCell = [Int]()
    
    // MARK: - Outlets
    @IBOutlet weak var reportList: UITableView!
    @IBOutlet weak var msgLbl: UILabel!
    
    // MARK: - Actions
    @IBAction func applyFilter(_ sender: UIBarButtonItem)
    {
        getFilterSheet(title: "Filter By", msg: "---------")
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
            
            cell.cityLbl.isHidden = true
            cell.staticCityLbl.isHidden = true
            
            cell.typeLbl.isHidden = true
            cell.staticTypeLbl.isHidden = true
            
            cell.descriptionLbl.isHidden = true
            cell.staticDetailsLbl.isHidden = true
            
            cell.animateImg.image = UIImage.init(named: "expand")
        }
        
        func refillCell()
        {
            cell.actBtn.isHidden = false
            
            cell.cityLbl.isHidden = false
            cell.staticCityLbl.isHidden = false
            
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
            
            cell.staticNameLbl.text = "Report ID:"
            cell.nameLbl.text = userReports[indexPath.row]?.reportID
            
            reportList.endUpdates()
        }
        else
        {
            reportList.beginUpdates()
            
            refillCell()
            
            cell.staticNameLbl.text = "Name: "
            cell.actBtn.layer.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0, blue: 1, alpha: 1)
            cell.nameLbl.text = userReports[indexPath.row]?.userName
            cell.cityLbl.text = userReports[indexPath.row]?.city
            cell.typeLbl.text = userReports[indexPath.row]?.reportType
            cell.descriptionLbl.text = userReports[indexPath.row]?.descriptionField
            
            reportList.endUpdates()
        }
        
        cell.backgroundColor = .clear
        cell.cellBackgroundView.layer.cornerRadius = 10
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
        
        func animate()
        {
            if isCellTapped == false
            {
                //selectedIndex = indexPath.row
                isCellTapped = true
                self.hiddensCell.append(indexPath.row)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            else
            {
//                if let index = self.hiddensCell.firstIndex(of: indexPath.row)
//                {
//                    self.hiddensCell.remove(at: index)
//                }
              
                if selectedIndex != hiddensCell.last
                {
                    isCellTapped = false
                    hiddensCell.removeLast()
                    
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                else
                {
                    if let index = self.hiddensCell.firstIndex(of: indexPath.row)
                    {
                        self.hiddensCell.remove(at: index)
                    }
                    isCellTapped = false
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
//                isCellTapped = false
//                tableView.reloadRows(at: [indexPath], with: .automatic)
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


extension AdminReportListController
{
    func getFilterSheet(title:String, msg:String)
    {
        let filterOptions = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        
        let filterByCityAction = UIAlertAction(title: "City", style: .default)
        {
            (_) in
            print("City")
        }
        
        let filterByPendingAction = UIAlertAction(title: "Pending", style: .default)
        {
            (_) in
            print("Pending")
        }
        
        let filterByInProcessAction = UIAlertAction(title: "In Process", style: .default)
        {
            (_) in
            print("In Process")
        }
        
        let filterByCompletedAction = UIAlertAction(title: "Completed", style: .default)
        {
            (_) in
            print("Completed")
        }
        
        let filterByNameAction = UIAlertAction(title: "Name", style: .default)
        {
            (_) in
            print("Name")
        }
        
//        let filterTextField = UIAlertAction(title: "Name Input", style: .default)
//        {
//            (alertAction) in
//            let textField = filterOptions.textFields![0] as UITextField
//        }
//
//        filterOptions.addTextField
//            {
//                (textField) in
//                textField.placeholder = "Enter your name"
//        }
        
        //filterOptions.addAction(filterTextField)
        filterOptions.addAction(filterByCityAction)
        filterOptions.addAction(filterByPendingAction)
        filterOptions.addAction(filterByInProcessAction)
        filterOptions.addAction(filterByCompletedAction)
        filterOptions.addAction(filterByNameAction)
        
        self.present(filterOptions, animated: true, completion: nil)
    }
    
}
