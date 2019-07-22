//
//  ReportListController.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 21/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import UIKit

class ReportListController: UIViewController {

    //Marks: Outlets
    
    @IBOutlet weak var reportList: UITableView!
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var firstReportBtn: UIButton!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    func checkReport()
    {
        if delegate.currentUser?.reportsID.count == 0
        {
            reportList.isHidden = true
            msgLbl.isHidden = false
            firstReportBtn.isHidden = false
        }
        else
        {
            reportList.isHidden = false
            msgLbl.isHidden = true
            firstReportBtn.isHidden = true
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        reportList.delegate     = self
        reportList.dataSource   = self
        
        checkReport()
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

extension ReportListController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = reportList.dequeueReusableCell(withIdentifier: "cell") as! reportTableViewCell
        
        cell.reportID.text = "123"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
}
