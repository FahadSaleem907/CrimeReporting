import Foundation
import UIKit

struct User
{
    var uid         : String?
    var name        : String
    var email       : String
    var password    : String?
    var userType    : String
    var image       : UIImage?
    var userStatus  : String
    var reports     : [Report?]
    var downloadURL : String
    init(uid:String?,name:String,email:String,pw:String?,userType:String,image:UIImage?,userStatus:String, report : [Report?], downloadURL: String)
    {
        self.uid            =   uid
        self.name           =   name
        self.email          =   email
        self.password       =   pw
        self.userType       =   userType
        self.image          =   image
        self.userStatus     =   userStatus
        self.reports        =   report
        self.downloadURL    =   downloadURL
    }
}
