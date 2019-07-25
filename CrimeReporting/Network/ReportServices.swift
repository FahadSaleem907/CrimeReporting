import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


public class reportFunctions
{
    var reportList = [Report?]()
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
    
    func createReport(reports:Report?, completion:@escaping(Report?,Bool?,String?)->Void)
    {
        var ref:DocumentReference? = nil
        
        let report1 = Report(reportID: reports!.reportID, city: reports!.city, descField: reports!.descriptionField, reportType: reports!.reportType, userID: delegate.currentUser!.uid!, time: reports!.time, img: reports?.image, pending: true, inProgress: false, completed: false)
        

        ref = self.db.collection("Reports").document()
        
        let dataDic = [
                        "reportID"          :"\(ref!.documentID)",
                        "uid"               :"\(delegate.currentUser!.uid!)",
                        "city"              :"\(report1.city)",
                        "time"              :"\(report1.time)",
                        "reportType"        :"\(report1.reportType)",
                        "reportDescription" :"\(report1.descriptionField)",
                        "pending"           : report1.isPending!,
                        "inProgress"        : report1.isInProgress!,
                        "completed"         : report1.isCompleted!
                       ] as [String : Any]
        
        ref?.setData(dataDic, completion:
            {
                (err) in
                if err != nil
                {
                    print("Error : \(err!.localizedDescription)")
                    completion(nil,false,err?.localizedDescription)
                }
                else
                {
                    print("Created")
                    completion(reports,true,nil)
                }
            })
        

//        ref = self.db.collection("Reports").addDocument(data: dataDic)
//        {
//            err in
//            if let err = err
//            {
//                print("Error : \(err.localizedDescription)")
//                completion(nil,false,err.localizedDescription)
//            }
//            else
//            {
//                dataDic["reportID"] = ref!.documentID
//                print(ref?.documentID)
//                print("Created")
//                completion(reports,true,nil)
//            }
//        }
        
        
    }

    func viewUserReports(completion:@escaping([Report?])->Void)
    {
        //var ref:DocumentReference? = nil

        let reportRef = self.db.collection("Reports")
        let query = reportRef.whereField("uid", isEqualTo: "\(delegate.currentUser!.uid!)")
        
        query.getDocuments
            {
                (snapshot, error) in
                if let error = error
                {
                    print("ERROR: \(error.localizedDescription)")
                    completion([])
                }
                else
                {
                    self.reportList = []
                    for i in snapshot!.documents
                    {
                        let tmpReport = Report(reportID: "asd", city: i.data()["city"] as! String, descField: i.data()["reportDescription"] as! String, reportType: i.data()["reportType"] as! String, userID: i.data()["uid"] as! String, time: i.data()["time"] as! String, img: nil, pending: i.data()["pending"] as? Bool, inProgress: i.data()["inProgress"] as? Bool, completed: i.data()["completed"] as? Bool)
                        
                        
                        self.reportList.append(tmpReport)
                    }
                    
                    completion(self.reportList)
                }
            }
        
        
        
    }
    
    func adminViewReports(completion:@escaping([Report?])->Void)
    {
        let reportRef = self.db.collection("Reports")
        let query = reportRef.whereField("uid", isEqualTo: "\(delegate.currentUser!.uid!)")
        
        reportRef.getDocuments
            {
                (snapshot, error) in
                if let error = error
                {
                    print("ERROR: \(error.localizedDescription)")
                    completion([])
                }
                else
                {
                    self.reportList = []
                    for i in snapshot!.documents
                    {
                        let tmpReport = Report(reportID: "asd", city: i.data()["city"] as! String, descField: i.data()["reportDescription"] as! String, reportType: i.data()["reportType"] as! String, userID: i.data()["uid"] as! String, time: i.data()["time"] as! String, img: nil, pending: i.data()["pending"] as? Bool, inProgress: i.data()["inProgress"] as? Bool, completed: i.data()["completed"] as? Bool)
                        
                        self.reportList.append(tmpReport)
                    }
                    completion(self.reportList)
                }
        }
    }

//    func adminGetUserData(completion:@escaping(User?)->Void)
//    {
//        let userRef = self.db.collection("Users")
//        
//        userRef.getDocuments
//            {
//                (snapshot, error) in
//            
//                if error != nil
//                {
//                    print(error!.localizedDescription)
//                }
//                else
//                {
//                    for i in snapshot!.documents
//                    {
//                        adminViewReports(completion:
//                            {
//                                (report) in
//                                
//                                for j in report
//                                {
//                                    while i.data()["uid"] as! String == j?.uid
//                                    {
//                                        return
//                                    }
//                                }
//                        })
//                    }
//                }
//        }
//    }
    
    
    
    func cancelReport()
    {
    
    }


    func changeReportStatus()
    {
    
    }
    
    

}
