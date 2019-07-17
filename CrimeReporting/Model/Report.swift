//
//  Report.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 17/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import Foundation
import UIKit

struct Report //: Codable
{
    var reportID            : String
    var city                : String
    var descriptionField    : String
    var reportType          : String
    var user                : User
    var time                : String
    var image               : UIImage?
    
    
    init(reportID : String , city : String , descField : String , reportType : String , user : User , time : String , img : UIImage? )
    {
        self.reportID           =   reportID
        self.city               =   city
        self.descriptionField   =   descField
        self.reportType         =   reportType
        self.user               =   user
        self.time               =   time
        self.image              =   img
    }
    
//    enum CodingKeys: String, CodingKey
//    {
//        case city               = "city"
//        case descriptionField   = "description"
//        case image              = "image"
//        case no                 = "no"
//        case rType              = "rType"
//    }
//
//    init(from decoder: Decoder) throws
//    {
//        let values              = try decoder.container(keyedBy: CodingKeys.self)
//            city                = try values.decodeIfPresent(String.self, forKey: .city)
//            descriptionField    = try values.decodeIfPresent(String.self, forKey: .descriptionField)
//            image               = try values.decodeIfPresent(String.self, forKey: .image)
//            no                  = try values.decodeIfPresent(String.self, forKey: .no)
//            rType               = try values.decodeIfPresent(String.self, forKey: .rType)
//    }
    
}
