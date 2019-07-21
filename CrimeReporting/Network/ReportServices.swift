//
//  ReportServices.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 17/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


public class reportFunctions
{
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
    
    func createReport(reports:Report?, completion:@escaping(Report?,Bool?,String?)->Void)
    {
        var ref:DocumentReference? = nil
        
        var report1 = Report(city: reports!.city, descField: reports!.descriptionField, reportType: reports!.reportType, user: reports!.user, time: reports!.time, img: reports?.image)
        
        let dataDic = ["city":"\(report1.city)",
                       "time":"\(report1.time)",
                       "reportType":"\(report1.reportType)",
                       "reportDescription":"\(report1.descriptionField)"
                      ]
        
        ref = db.collection("Reports").addDocument(data: dataDic)
        {
            err in
            if let err = err
            {
                print("Error : \(err.localizedDescription)")
                completion(nil,false,err.localizedDescription)
            }
            else
            {
                print("Created")
                completion(reports,true,nil)
            }
        }
        
        
    }

    func viewReports()
    {
        //var ref:DocumentReference? = nil
        
        
    }
    
    func cancelReport()
    {
    
    }


    func changeReportStatus()
    {
    
    }
    
    

}
