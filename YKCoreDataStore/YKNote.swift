//
//  YKNote.swift
//  YKCoreDataStore
//
//  Created by Ya Kao on 6/28/16.
//  Copyright © 2016 Ya Kao. All rights reserved.
//

import Foundation
import CoreData


class YKNote: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    convenience init(text:String = "New Note", context: NSManagedObjectContext){
        if let entity = NSEntityDescription.entityForName("Note", inManagedObjectContext: context){
            self.init(entity: entity, insertIntoManagedObjectContext: context)
            self.text = text
            self.creationDate = NSDate()
            
        }else{
            fatalError("Unable to find Entity name!")
        }
    }
    
    //MARK: - helper function
    var humanReadableAge: String{
        get{
            let formatter = NSDateFormatter()
            formatter.timeStyle = .NoStyle
            formatter.dateStyle = .ShortStyle
            formatter.locale = NSLocale.currentLocale()
            formatter.doesRelativeDateFormatting = true
            
            return formatter.stringFromDate(self.creationDate!)
        }
    }
}
