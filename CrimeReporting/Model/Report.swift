import Foundation
import UIKit

struct Report
{
    var reportID            : String
    var city                : String
    var descriptionField    : String
    var reportType          : String
    var uid                 : String
    var time                : String
    var image               : UIImage?
    var isPending           : Bool?
    var isInProgress        : Bool?
    var isCompleted         : Bool?
    
    init(reportID : String , city : String , descField : String , reportType : String , userID : String , time : String , img : UIImage? , pending : Bool? , inProgress : Bool? , completed : Bool? )
    {
        self.reportID           =   reportID
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
}
