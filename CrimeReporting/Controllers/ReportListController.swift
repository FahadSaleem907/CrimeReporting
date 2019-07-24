//
//  ReportListController.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 21/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import UIKit

class ReportListController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var reportList: UITableView!
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var firstReportBtn: UIButton!
    
    
    // MARK: - Actions
    
    @IBAction func filter(_ sender: UIBarButtonItem)
    {
        filterCount = filterCount + 1
        
        applyFilter()
    }
    
    
    
    // MARK: - Constants
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    let reportServices = reportFunctions()
    
    // MARK: - Variables
    var userReports = [Report?](){
        didSet{
            reportList.reloadData()
        }
    }
    var filterCount = 0
    
    
    // MARK: - Functions
    
    func applyFilter()
    {
        if filterCount == 0
        {
            userReports = delegate.currentUser!.reports
            //reportList.reloadData()
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
        if delegate.currentUser?.reports.count == 0
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
    
    override func viewWillAppear(_ animated: Bool)
    {
        userReports = delegate.currentUser!.reports
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        reportList.delegate     = self
        reportList.dataSource   = self
        
        checkReport()
        
        userReports = delegate.currentUser!.reports
    }

}

extension ReportListController: UITableViewDelegate,UITableViewDataSource
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
        cell.reportID.text = userReports[indexPath.row]?.reportType
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75
    }
}
