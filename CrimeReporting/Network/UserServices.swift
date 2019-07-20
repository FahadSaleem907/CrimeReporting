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
    
    func createUser(user:User?, completion:@escaping(User?, Bool?,String?)->Void)
    {
        let db = Firestore.firestore()
        
        var ref:DocumentReference? = nil
    
        Auth.auth().createUser(withEmail: user!.email, password: user!.password)
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
                    
                ref = db.collection("\(users!.userType)").document("\(users!.uid!)").collection("\(users!.userStatus)").document("\(users!.email)")
                
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
