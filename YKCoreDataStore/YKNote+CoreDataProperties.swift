//
//  YKNote+CoreDataProperties.swift
//  YKCoreDataStore
//
//  Created by Ya Kao on 6/28/16.
//  Copyright © 2016 Ya Kao. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension YKNote {

    @NSManaged var text: String?
    @NSManaged var creationDate: NSDate?
    @NSManaged var notebook: YKNotebook?

}
