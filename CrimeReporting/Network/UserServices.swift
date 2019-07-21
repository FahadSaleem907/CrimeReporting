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
        
        delegate.currentUser = User(uid: "asd", name: "asd", email: "asd", pw: nil, userType: "asd", image: nil, userStatus: "asd")
        
        Auth.auth().signIn(withEmail: email, password: password)
        {
            (result, error) in
            
            
            guard let _ = result?.user,
                let uid = result?.user.uid
            else
            {
                print("ERROR : \(error?.localizedDescription)")
                completion(nil,false,error!.localizedDescription)
                return
            }
            
            
            var ref:DocumentReference? = nil
            
            let type = ["Admin","User"]
            let status = ["Active","Inactive"]
            
            for i in type
            {
                if i == "Admin"
                {
                    for j in status
                    {
                        if j == "Active"
                        {
                            ref = self.db.collection("Admin").document("\(uid)").collection("Active").document("\(email)")
                            ref?.getDocument(completion:
                                {
                                    (snapshot, error) in
                                    if let snapshot = snapshot
                                    {
                                        if snapshot.data() != nil
                                        {
                                            self.delegate.currentUser?.uid = snapshot.data()!["uid"] as! String
                                            self.delegate.currentUser?.email = snapshot.data()!["email"] as! String
                                            self.delegate.currentUser?.name = snapshot.data()!["name"] as! String
                                            self.delegate.currentUser?.userType = "Admin"
                                            self.delegate.currentUser?.userStatus = "Active"
                                            print("Active Admin Cached document data: \(self.delegate.currentUser)")
                                        }
                                        else
                                        {
                                            print(error?.localizedDescription)
                                        }
                                    }
                                    else
                                    {
                                        print("Document does not exist in cache")
                                    }
                                })
                        }
                        if j == "Inactive"
                        {
                            ref = self.db.collection("Admin").document("\(uid)").collection("Inactive").document("\(email)")
                            ref?.getDocument(completion:
                                {
                                    (snapshot, error) in
                                    if let snapshot = snapshot
                                    {
                                        if snapshot.data() != nil
                                        {
                                            self.delegate.currentUser?.uid = snapshot.data()!["uid"] as! String
                                            self.delegate.currentUser?.email = snapshot.data()!["email"] as! String
                                            self.delegate.currentUser?.name = snapshot.data()!["name"] as! String
                                            self.delegate.currentUser?.userType = "Admin"
                                            self.delegate.currentUser?.userStatus = "Inactive"
                                            print("Inactive Admin Cached document data: \(self.delegate.currentUser)")
                                        }
                                        else
                                        {
                                            print(error?.localizedDescription)
                                        }
                                    }
                                    else
                                    {
                                        print("Document does not exist in cache")
                                    }
                                })
                        }
                    }
                }
                if i == "User"
                {
                    for j in status
                    {
                        if j == "Active"
                        {
                            ref = self.db.collection("User").document("\(uid)").collection("Active").document("\(email)")
                            ref?.getDocument(completion:
                                {
                                    (snapshot, error) in
                                    if let snapshot = snapshot
                                    {
                                        //let dataDescription = snapshot.data().map(String.init(describing:)) ?? "nil"
                                        if snapshot.data() != nil
                                        {
                                            //print("DDDDD \(snapshot.data())")
                                            self.delegate.currentUser?.uid = (snapshot.data()!["uid"] as! String)
                                            self.delegate.currentUser?.email = snapshot.data()!["email"] as! String
                                            self.delegate.currentUser?.name = snapshot.data()!["name"] as! String
                                            self.delegate.currentUser?.userType = "User"
                                            self.delegate.currentUser?.userStatus = "Active"
                                            print("Active User Cached document data: \(self.delegate.currentUser!)")
                                        }
                                        else
                                        {
                                            print(error?.localizedDescription)
                                        }
                                    }
                                    else
                                    {
                                        print("Document does not exist in cache")
                                    }
                                })
                        }
                        if j == "Inactive"
                        {
                            ref = self.db.collection("User").document("\(uid)").collection("Inactive").document("\(email)")
                            ref?.getDocument(completion:
                                {
                                    (snapshot, error) in
                                    if let snapshot = snapshot
                                    {
                                        if snapshot.data() != nil
                                        {
                                            print("FFFFFF \(snapshot.data())")
                                            self.delegate.currentUser?.uid = snapshot.data()!["uid"] as! String
                                            self.delegate.currentUser?.email = snapshot.data()!["email"] as! String
                                            self.delegate.currentUser?.name = snapshot.data()!["name"] as! String
                                            self.delegate.currentUser?.userType = "User"
                                            self.delegate.currentUser?.userStatus = "Inactive"
                                            print("Inactive User Cached document data: \(self.delegate.currentUser)")
                                        }
                                        else
                                        {
                                            print(error?.localizedDescription)
                                        }
                                    }
                                    else
                                    {
                                        print("Document does not exist in cache")
                                    }
                                })
                        }
                    }
                }
            }
            
            
            
        }
    }
    
    
    
    func createUser(user:User?, completion:@escaping(User?, Bool?,String?)->Void)
    {
        var ref:DocumentReference? = nil
    
        Auth.auth().createUser(withEmail: user!.email, password: user!.password!)
        { (result, err) in
            
            if err == nil
            {
                var users:User? = User(uid: user!.uid, name: user!.name, email: user!.email, pw: user!.password, userType: user!.userType, image: nil, userStatus: "Active")
                
                users?.uid = result!.user.uid
                users?.userStatus = "Active"
                users?.name = user!.name
                users?.password = user!.password
                users?.email = user!.email
                users?.userType = user!.userType
                print("created")
                print(users!.name, users!.uid! , users!.userStatus)
                
                let dataDic:[String:Any] = ["name" : "\(users!.name)",
                                            "email": "\(users!.email)",
                                            "uid"  : "\(users!.uid!)"
                                            ]
                    
                ref = self.db.collection("\(users!.userType)").document("\(users!.uid!)").collection("\(users!.userStatus)").document("\(users!.email)")
                
                ref?.setData(dataDic)
                {
                    err in
                    if let err = err
                    {
                        print("Error : \(err.localizedDescription)")
                    }
                    else
                    {
                        print("Created")
                    }
                }
                completion(users,true,nil)
            }
            else
            {
                completion(nil, false , err?.localizedDescription)
            }
        }
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
