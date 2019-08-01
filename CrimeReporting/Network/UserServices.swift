//
//  UserServices.swift
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

public class userFunctions
{
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
    
    func login(email:String,password:String,completion:@escaping(User?,Bool?,String?)->Void)
    {
        var reportList = [Report?]()
        
        delegate.currentUser = User(uid: "asd", name: "asd", email: "asd", pw: nil, userType: "asd", image: nil, userStatus: "asd", report: [])
        
        Auth.auth().signIn(withEmail: email, password: password)
        {
            (result, error) in
            
            
            guard let _ = result?.user,
                let uid = result?.user.uid
            else
            {
                print("ERROR : \(error!.localizedDescription)")
                completion(nil,false,error!.localizedDescription)
                return
            }
            
            
            var ref:DocumentReference? = nil
            
            //let type = ["Admin","User"]
            //let status = ["Active","Inactive"]
            
            ref = self.db.collection("Users").document("\(uid)")
            ref?.getDocument(completion:
                {
                    (snapshot, error) in
                    if let snapshot = snapshot
                    {
                        if snapshot.data() != nil
                        {
                            self.delegate.currentUser?.uid = (snapshot.data()!["uid"] as! String)
                            self.delegate.currentUser?.email = snapshot.data()!["email"] as! String
                            self.delegate.currentUser?.name = snapshot.data()!["name"] as! String
                            self.delegate.currentUser?.userType = snapshot.data()!["User Type"] as! String
                            self.delegate.currentUser?.userStatus = snapshot.data()!["User Status"] as! String
                            //print("Active Admin Cached document data: \(self.delegate.currentUser)")
                            let reportService = reportFunctions()
                            
                            if self.delegate.currentUser!.userType == "User"
                            {
                            reportService.viewUserReports(completion:
                                {
                                    (report) in
                                    
                                    reportList = report
                                    
                                    print(reportList)
                                    self.delegate.currentUser?.reports = reportList
                                })
                            }
                            else
                            {
                                reportService.adminViewReports(completion:
                                    {
                                        (report) in
                                    
                                        reportList = report
                                        print(reportList)
                                        self.delegate.currentUser?.reports = reportList
                                })
                            }
                            completion(self.delegate.currentUser,true,nil)
                        }
                        else
                        {
                            completion(nil,false,error?.localizedDescription)
                        }
                    }
                    else
                    {
                        completion(nil,false,error?.localizedDescription)
                    }
            })
            
        }
    }
    
    
    
    func createUser(user:User?,completion:@escaping(String?,User?, Bool?,String?)->Void)
    {
        var ref:DocumentReference? = nil
    
        Auth.auth().createUser(withEmail: user!.email, password: user!.password!)
        { (result, mainErr) in
            
            if mainErr == nil
            {
                var users:User? = User(uid: user!.uid, name: user!.name, email: user!.email, pw: user!.password, userType: user!.userType, image: nil, userStatus: "Active", report: [])
                
                users?.uid = result!.user.uid
                users?.userStatus = "Active"
                users?.name = user!.name
                users?.password = user!.password
                users?.email = user!.email
                users?.userType = user!.userType
                print("created")
                print(users!.name, users!.uid! , users!.userStatus)
                
                let dataDic:[String:Any] = ["name"          : "\(users!.name)",
                                            "email"         : "\(users!.email)",
                                            "uid"           : "\(users!.uid!)",
                                            "User Type"     : "\(users!.userType)",
                                            "User Status"   : "\(users!.userStatus)",
                                            "Reports"       : "Nil"
                                            ]
                
                ref = self.db.collection("Users").document("\(users!.uid!)")
                ref?.setData(dataDic)
                {
                    err in
                    if let err = err
                    {
                        print("Error : \(err.localizedDescription)")
                        completion(nil,nil,false,err.localizedDescription)
                    }
                    else
                    {
                        print("Created")
                        completion(nil,users,true,nil)
                    }
                }
                //completion(nil,users,true,nil)
            }
            else
            {
                let authError = mainErr?.localizedDescription
                //print(authError)
                completion(authError ,nil, false , nil)
            }
        }
    }


    func getReAuth(completion:@escaping(User?,Bool?,String?)->Void)
    {
        var reportList = [Report?]()
        var ref:DocumentReference? = nil
        
        ref = self.db.collection("Users").document("\(Auth.auth().currentUser?.uid)")
        ref?.getDocument(completion:
            {
                (snapshot, error) in
                if let snapshot = snapshot
                {
                    if snapshot.data() != nil
                    {
                        self.delegate.currentUser?.uid = (snapshot.data()!["uid"] as! String)
                        self.delegate.currentUser?.email = snapshot.data()!["email"] as! String
                        self.delegate.currentUser?.name = snapshot.data()!["name"] as! String
                        self.delegate.currentUser?.userType = snapshot.data()!["User Type"] as! String
                        self.delegate.currentUser?.userStatus = snapshot.data()!["User Status"] as! String
                        //print("Active Admin Cached document data: \(self.delegate.currentUser)")
                        let reportService = reportFunctions()
                        
                        if self.delegate.currentUser!.userType == "User"
                        {
                            reportService.viewUserReports(completion:
                                {
                                    (report) in
                                    
                                    reportList = report
                                    
                                    print(reportList)
                                    self.delegate.currentUser?.reports = reportList
                            })
                        }
                        else
                        {
                            reportService.adminViewReports(completion:
                                {
                                    (report) in
                                    
                                    reportList = report
                                    print(reportList)
                                    self.delegate.currentUser?.reports = reportList
                            })
                        }
                        completion(self.delegate.currentUser,true,nil)
                    }
                    else
                    {
                        completion(nil,false,error?.localizedDescription)
                    }
                }
                else
                {
                    completion(nil,false,error?.localizedDescription)
                }
        })
    }

    func deleteUser()
    {
        
    }


    func changePw()
    {
    
    }


    func changeEmail()
    {
    
    }

}
