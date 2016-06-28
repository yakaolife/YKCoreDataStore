//
//  YKNotebook.swift
//  YKCoreDataStore
//
//  Created by Ya Kao on 6/28/16.
//  Copyright © 2016 Ya Kao. All rights reserved.
//

//YKNote & YKNotebook are created the same way as Udacity's Core Data class

import Foundation
import CoreData


class YKNotebook: NSManagedObject {

    convenience init(title:String, context: NSManagedObjectContext){
        if let entity = NSEntityDescription.entityForName("Notebook", inManagedObjectContext: context){
            self.init(entity: entity, insertIntoManagedObjectContext: context)
            self.title = title
            self.creationDate = NSDate()
            
        }else{
            fatalError("Unable to find Entity name!")
        }
    }

}
