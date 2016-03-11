
import UIKit

class Trail: NSObject {
    var tName:String
    var tAddress:String
    var tDistance:Float
    var tConditions:String
    var tPhoneNumber:String
    var tPictures:[String]
    
    init(name:String, address:String, distance:Float, conditions:String, phoneNumber:String, pictures:[String]){
        self.tName = name
        self.tAddress = address
        self.tDistance = distance
        self.tConditions = conditions
        self.tPhoneNumber = phoneNumber
        self.tPictures = pictures
    }
}
