import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class AdminDashboardController: UIViewController
{
    // MARK: - Constants
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let reportServices = reportFunctions()
    
    // MARK: - Variables
    var layoutSize:CGSize?
    var reportsList = [Report?]()
    var userReports = [Report?]()
    {
        didSet
        {
            reportNumbers.reloadData()
        }
    }

    // MARK: - Actions
    
    @IBAction func logout(_ sender: UIButton)
    {
        handleLogout()
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var reportNumbers: UICollectionView!
    
    // MARK: - Functions
    
    @objc func handleLogout()
    {
        do
        {
            try Auth.auth().signOut()
            
            //let loginController = MainViewController()
            print(Auth.auth().currentUser?.uid)
            
            self.dismiss(animated: true, completion: nil)
        }
        catch let logoutError
        {
            print(logoutError)
        }
    }
    
    func getSize()
    {
        layoutSize = reportNumbers.frame.size
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
    
    override func viewDidLayoutSubviews()
    {
        getSize()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        getData
            { (report) in
            self.userReports.removeAll()
            self.userReports = report
            //self.checkReport()
        }
        reportNumbers.reloadData()
        
        //getSize()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        reportNumbers.delegate      = self
        reportNumbers.dataSource    = self
        
        getSize()
    }
}

extension AdminDashboardController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
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
        let cell = reportNumbers.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AdminDashboardCollectionViewCell
        
        func setBackgroundColor()
        {
            cell.mainCellView.frame.size = layoutSize!
            cell.mainCellView.backgroundColor = .clear
            
            if indexPath.item == 0
            {
                cell.reportCount.text = String(delegate.currentUser!.reports.count)
                cell.reportText.text  = "Total Reports"
                cell.backgroundImg.image = UIImage.init(named: "blue1")
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
                cell.backgroundImg.image = UIImage.init(named: "yellow")
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
                cell.backgroundImg.image = UIImage.init(named: "orange")
                
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
                cell.backgroundImg.image = UIImage.init(named: "green1")
            }
        }
        
        setBackgroundColor()
        
        return cell
    }
}
