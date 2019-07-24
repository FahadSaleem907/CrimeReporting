//
//  User.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 17/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import Foundation
import UIKit

struct User //: Codable
{
    var uid         : String?
    var name        : String
    var email       : String
    var password    : String?
    var userType    : String
    var image       : UIImage?
    var userStatus  : String
    var reports   : [Report?]
    
    init(uid:String?,name:String,email:String,pw:String?,userType:String,image:UIImage?,userStatus:String, report : [Report?])
    {
        self.uid        =   uid
        self.name       =   name
        self.email      =   email
        self.password   =   pw
        self.userType   =   userType
        self.image      =   image
        self.userStatus =   userStatus
        self.reports    =   report
    }
    
//    enum CodingKeys: String, CodingKey
//    {
//        case email      = "email"
//        case name       = "name"
//        case password   = "password"
//        case role       = "Role"
//        case image      = "Image"
//    }
//
//    init(from decoder: Decoder) throws
//    {
//        let values      = try decoder.container(keyedBy: CodingKeys.self)
//            email       = try values.decodeIfPresent(String.self,   forKey: .email)
//            name        = try values.decodeIfPresent(String.self,   forKey: .name)
//            password    = try values.decodeIfPresent(String.self,   forKey: .password)
//            role        = try values.decodeIfPresent(Bool.self,     forKey: .role)
//            image = try values.decodeIfPresent(UIImage.self, forKey: .image)
//    }
    
}
