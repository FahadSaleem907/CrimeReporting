//
//  DashboardController.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 21/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import UIKit

class DashboardController: UIViewController
{
    
    let layout = UICollectionViewFlowLayout()

    //Marks: Outlets
    
    @IBOutlet weak var reportNumbers: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reportNumbers.delegate      = self
        reportNumbers.dataSource    = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DashboardController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = reportNumbers.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! dashboardCollectionViewCell
        
        func setBackgroundColor()
        {
            if indexPath.item == 0
            {
                cell.reportCount.text = "10"
                cell.reportText.text  = "Total Reports"
                cell.backgroundColor = .red
            }
            if indexPath.item == 1
            {
                cell.reportCount.text = "3"
                cell.reportText.text = "Pending Reports"
                cell.backgroundColor = .green
            }
            if indexPath.item == 2
            {
                cell.reportCount.text = "7"
                cell.reportText.text = "Completed Reports"
                cell.backgroundColor = .blue
            }
        }
        
        setBackgroundColor()
        
        return cell
    }
}
