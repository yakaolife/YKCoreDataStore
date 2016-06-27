//
//  YKData.swift
//  YKCoreDataStore
//
//  Created by Ya Kao on 6/26/16.
//  Copyright © 2016 Ya Kao. All rights reserved.
//

import UIKit
import CoreData

//Sample data

class YKData: NSObject {
    
    var uid: String
    var title: String = "Default data title"
    var value: Int = 0
    
    //Just another object class inside the current YKData
    var innerData: YKInnerData
    
    init(title:String, value: Int, innerData: YKInnerData) {
        self.title = title
        self.value = value
        self.innerData = innerData
        
        //Generate UID via datastore
        self.uid = YKDataStore.sharedInstance.generateHabitUid(self.title)
    }
    
    //Convenience init coming from Core Data
    
    init(coreDataObj: NSManagedObject){
        
        self.title = (coreDataObj.valueForKey("title") as? String)!
        self.uid = (coreDataObj.valueForKey("uid") as? String)!
        self.value = (coreDataObj.valueForKey("value") as? Int)!

        
        //YKInnerData
        
        let innerDataManaged = (coreDataObj.valueForKey("innerData")) as! NSManagedObject
        
        //TODO: using guard let? So that if one of the value is empty?
        let title = innerDataManaged.valueForKey("title") as? String
        let value = innerDataManaged.valueForKey("value") as? Int
        //technically this will be the same as self.uid
        let dataUID = innerDataManaged.valueForKey("dataUID") as? String
        
        self.innerData = YKInnerData(title: title!, value: value!, dataUID: dataUID!)
    }

}
