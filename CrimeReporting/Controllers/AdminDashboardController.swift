import Foundation
import UIKit

class AdminDashboardController: UIViewController
{

    let delegate = UIApplication.shared.delegate as! AppDelegate
    var layoutSize:CGSize?
    
    
    func getSize()
    {
        layoutSize = reportNumbers.frame.size
    }
    
    @IBOutlet weak var reportNumbers: UICollectionView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            if indexPath.item == 0
            {
                //cell.reportCount.text = String(delegate.currentUser!.reports.count)
                //cell.reportText.text  = "Total Reports"
                cell.backgroundColor = .blue
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
                
                //cell.reportCount.text = String(tmpArray.count)
                //cell.reportText.text  = "Pending Reports"
                cell.backgroundColor = .yellow
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
                
                //cell.reportCount.text = String(tmpArray.count)
                //cell.reportText.text = "Reports In Progress"
                cell.backgroundColor = .orange
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
                //cell.reportCount.text = String(tmpArray.count)
                //cell.reportText.text = "Completed Reports"
                cell.backgroundColor = .green
            }
        }
        
        setBackgroundColor()
        
        return cell
    }
}
