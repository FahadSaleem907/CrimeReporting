//
//  reportStatus.swift
//  CrimeReporting
//
//  Created by FahadSaleem on 17/07/2019.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import Foundation


struct reportStatus //: Codable
{
    
    var reportID        : String
    var status          : String
    var uid             : String
    var time            : String
    
//    enum CodingKeys: String, CodingKey
//    {
//        case rid    = "rid"
//        case status = "status"
//        case uid    = "uid"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values  = try decoder.container(keyedBy: CodingKeys.self)
//            rid     = try values.decodeIfPresent(Int.self,      forKey: .rid)
//            status  = try values.decodeIfPresent(String.self,   forKey: .status)
//            uid     = try values.decodeIfPresent(Int.self,      forKey: .uid)
//    }
    
}
