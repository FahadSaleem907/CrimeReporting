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
    //var reportID            : String
    var city                : String
    var descriptionField    : String
    var reportType          : String
    var uid                 : String
    var time                : String
    var image               : UIImage?
    var isPending           : Bool?
    var isInProgress        : Bool?
    var isCompleted         : Bool?
    
    init(/*reportID : String ,*/ city : String , descField : String , reportType : String , userID : String , time : String , img : UIImage? , pending : Bool? , inProgress : Bool? , completed : Bool? )
    {
        //self.reportID           =   reportID
        self.city               =   city
        self.descriptionField   =   descField
        self.reportType         =   reportType
        self.uid                =   userID
        self.time               =   time
        self.image              =   img
        self.isPending          =   pending
        self.isInProgress       =   inProgress
        self.isCompleted        =   completed
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
