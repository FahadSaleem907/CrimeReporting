import Foundation
import UIKit

class UserDashboardController: UIViewController
{
    // MARK: - Constants
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let reportServices = reportFunctions()
    
    // MARK: - Variables
    var layoutSize:CGSize?
    var reportsList = [Report?]()
    var userReports = [Report?]()
    
    // MARK: - Actions
    
    
    
    // MARK: - Outlets
    @IBOutlet weak var reportNumbers: UICollectionView!
    
    // MARK: - Functions
    func getSize()
    {
        layoutSize = reportNumbers.frame.size
    }
    
//    func getData(completion:@escaping([Report?])->Void)
//    {
//        reportServices.viewUserReports
//            {
//                (report) in
//
//                self.delegate.currentUser!.reports.removeAll()
//                self.reportsList = report
//                self.delegate.currentUser?.reports = self.reportsList
//                completion(self.delegate.currentUser!.reports)
//        }
//    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
//        getData { (report) in
//            self.userReports.removeAll()
//            self.userReports = report
//        }
        reportNumbers.reloadData()
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        reportNumbers.delegate      = self
        reportNumbers.dataSource    = self
        
        getSize()
    }
}

extension UserDashboardController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return layoutSize!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = reportNumbers.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! dashboardCollectionViewCell
        
        func setBackgroundColor()
        {
            if indexPath.item == 0
            {
                cell.reportCount.text = String(delegate.currentUser!.reports.count)
                cell.reportText.text  = "Total Reports"
                cell.backgroundColor = .blue
                cell.layer.cornerRadius = 15
            }
            if indexPath.item == 1
            {
                var tmpArray = [Report?]()
                
                for i in delegate.currentUser!.reports
                {
                    if i?.isPending == true
                    {
                        tmpArray.append(i)
                    }
                }
                
                cell.reportCount.text = String(tmpArray.count)
                cell.reportText.text  = "Pending Reports"
                cell.backgroundColor = .yellow
                cell.layer.cornerRadius = 15
            }
            if indexPath.item == 2
            {
                var tmpArray = [Report?]()
                for i in delegate.currentUser!.reports
                {
                    if i?.isInProgress == true
                    {
                        tmpArray.append(i)
                    }
                }
                
                cell.reportCount.text = String(tmpArray.count)
                cell.reportText.text = "Reports In Progress"
                cell.backgroundColor = .orange
                cell.layer.cornerRadius = 15
            }
            if indexPath.item == 3
            {
                var tmpArray = [Report?]()
                for i in delegate.currentUser!.reports
                {
                    if i?.isCompleted == true
                    {
                        tmpArray.append(i)
                    }
                }
                cell.reportCount.text = String(tmpArray.count)
                cell.reportText.text = "Completed Reports"
                cell.backgroundColor = .green
                cell.layer.cornerRadius = 15
            }
        }
        
        setBackgroundColor()
        
        return cell
    }
}
