//
//  YKInnerData.swift
//  YKCoreDataStore
//
//  Created by Ya Kao on 6/26/16.
//  Copyright © 2016 Ya Kao. All rights reserved.
//

import UIKit

//Just another data model to demonstrate how to have object within another object, etc.

class YKInnerData: NSObject {
    
    //The YKData's uid this YKInnerData belongs to
    var dataUID: String
    var title: String = "Inner data title"
    var value: Int = 0
    
    init(title: String, value: Int, dataUID: String) {
        self.title = title
        self.value = value
        self.dataUID = dataUID
    }
    
    //Convenience constructer from CoreData?
    

}
