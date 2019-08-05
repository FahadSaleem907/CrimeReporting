import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


public class reportFunctions
{
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
    let cities = ["Karachi","Lahore","Islamabad","Faisalabad","Hyderabad","Peshawar","Murree"]
    let reportTypes = ["Kidnapping","Homicide","Mugging","Assault And Batter","Sexual Assault","Hit and Run", "Breaking and Entering", "Destruction of Public Property","Embezzlement", "Forgery"]
    
    var reportList = [Report?]()
    
    func createReport(reports:Report?, completion:@escaping(Report?,Bool?,String?)->Void)
    {
        var ref:DocumentReference? = nil
        
        let report1 = Report(reportID: reports!.reportID, city: reports!.city, descField: reports!.descriptionField, reportType: reports!.reportType, userID: delegate.currentUser!.uid!, time: reports!.time, img: reports?.image, pending: true, inProgress: false, completed: false, userName: delegate.currentUser!.name)
        

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
                        "completed"         : report1.isCompleted!,
                        "userName"          :"\(delegate.currentUser!.name)"
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
    }

    func viewUserReports(completion:@escaping([Report?])->Void)
    {
        //var ref:DocumentReference? = nil

        let reportRef = self.db.collection("Reports")
        let query = reportRef.whereField("uid", isEqualTo: "\(delegate.currentUser!.uid!)")
        
        query.addSnapshotListener
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
                        let tmpReport = Report(reportID: "asd", city: i.data()["city"] as! String, descField: i.data()["reportDescription"] as! String, reportType: i.data()["reportType"] as! String, userID: i.data()["uid"] as! String, time: i.data()["time"] as! String, img: nil, pending: i.data()["pending"] as? Bool, inProgress: i.data()["inProgress"] as? Bool, completed: i.data()["completed"] as? Bool, userName: i.data()["userName"] as! String)
                        
                        
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
        
        reportRef.addSnapshotListener
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
                        let tmpReport = Report(reportID: i.documentID, city: i.data()["city"] as! String, descField: i.data()["reportDescription"] as! String, reportType: i.data()["reportType"] as! String, userID: i.data()["uid"] as! String, time: i.data()["time"] as! String, img: nil, pending: i.data()["pending"] as? Bool, inProgress: i.data()["inProgress"] as? Bool, completed: i.data()["completed"] as? Bool, userName: i.data()["userName"] as! String)
                        
                        self.reportList.append(tmpReport)
                    }
                    completion(self.reportList)
                }
        }
    }

    
    func cancelReport()
    {
    
    }


    func pendingReportStatus(reportID:String,value:Bool)
    {
        let ref = self.db.collection("Reports")
        //let queryStatusChange = ref.whereField("reportID", isEqualTo: reportID)
        
        let dataDic = [ "pending"       : false,
                        "inProgress"    : true,
                        "completed"     : false
                      ]
        
        ref.document("\(reportID)").updateData(dataDic)
    }
    
    func inProcessReportStatus(reportID:String,value:Bool)
    {
        let ref = self.db.collection("Reports")
        //let queryStatusChange = ref.whereField("reportID", isEqualTo: reportID)
        
        let dataDic = [ "pending"       : false,
                        "inProgress"    : false,
                        "completed"     : true
                      ]
        
        ref.document("\(reportID)").updateData(dataDic)
    }
    
//    func completedReportStatus(reportID:String,value:Bool)
//    {
//        let ref = self.db.collection("Reports")
//        //let queryStatusChange = ref.whereField("reportID", isEqualTo: reportID)
//
//        let dataDic = [ "pending"       : false,
//                        "inProgress"    : false,
//                        "completed"     : true
//        ]
//
//        queryStatusChange.setValue(!value, forKey: "isPending")
//        queryStatusChange.setValue(!value, forKey: "isInProgress")
//        queryStatusChange.setValue(value, forKey: "isCompleted")
//    }
    
    
    func filterReports(filterType: String,completion:@escaping([Report?])->Void)
    {
        let ref = self.db.collection("Reports")
        let filterQuery = ref.whereField("city", isEqualTo: filterType)
        
        filterQuery.addSnapshotListener
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
                        let tmpReport = Report(reportID: i.documentID, city: i.data()["city"] as! String, descField: i.data()["reportDescription"] as! String, reportType: i.data()["reportType"] as! String, userID: i.data()["uid"] as! String, time: i.data()["time"] as! String, img: nil, pending: i.data()["pending"] as? Bool, inProgress: i.data()["inProgress"] as? Bool, completed: i.data()["completed"] as? Bool, userName: i.data()["userName"] as! String)
                        
                        
                        self.reportList.append(tmpReport)
                    }
                    
                    completion(self.reportList)
                }
        }
    }
    
}
