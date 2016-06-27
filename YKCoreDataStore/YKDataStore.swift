//
//  YKDataStore.swift
//  YKCoreDataStore
//
//  Created by Ya Kao on 6/26/16.
//  Copyright © 2016 Ya Kao. All rights reserved.
//

import UIKit
import CoreData

//This is mostly for handling core data operation so any view controller can use the method here

class YKDataStore {
    
    //MARK: - Initialization
    
    //One line singleton!
    static let sharedInstance = YKDataStore()
    //Not sure if I can do this
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var managedContext: NSManagedObjectContext
    
    //MARK: - Error Handling
    
    enum DataError: ErrorType{
        case SavingError
    }
    
    //Prevents other people using default init()
    private init() {
        managedContext = appDelegate.managedObjectContext
    }
    
    //MARK: - Fetch Data
    
    // predicate can be nill or not
    func fetchData(entityName: String, predicate: NSPredicate?)->[NSManagedObject]{
        
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        if predicate != nil{
            fetchRequest.predicate = predicate
        }
        
        var data = [NSManagedObject]()
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            data =  results as! [NSManagedObject]
            
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
            
        }
        
        return data
    }
    
    //MARK: - Save Data
    
    // Getting the type of entity to save
    // Example: if there's an entity named "Schedule"
    //  let schedule = getManagedObjectToSet("Schedule")
    //  schedule.setValue(scheduleTypeValue, forKey: "type")
    
    func getManagedObjectToSet(entityName: String)-> NSManagedObject{
        //print("dataStore:getManageObjectToSet: entityName: \(entityName)")
        
        let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedContext)
        
        let managedObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        return managedObject
    }
    
    
    //Modify + Save New Data, generic example
    
    func saveData(data: YKData) throws{
        
        
        //See if this is Modify
        //Find the original in Core Data to edit
        var predicate = NSPredicate(format: "uid == %@", data.uid)
        let foundData = fetchData("YKData", predicate: predicate)
        
        if foundData.count == 1{
            //Edit
            //Found the one we want to edit! Except uid, which remains unchange
            
            foundData[0].setValue(data.title, forKey: "title")
            foundData[0].setValue(data.value, forKey: "value")
            
            //InnerData
            //TODO: get the value through foundData?
            
            predicate = NSPredicate(format: "dataUID == %@", data.uid)
            let foundInnerData = fetchData("YKInnerData", predicate: predicate)
            
            if foundInnerData.count == 1{
                
                foundInnerData[0].setValue(data.innerData.title, forKey: "title")
                foundInnerData[0].setValue(data.innerData.value, forKey: "value")
                
            }else{
                print("No InnderData, something is wrong?")
            }
            
            
        }else{
            //Save the new data!
            
            let coreHabit = getManagedObjectToSet("YKData")
            coreHabit.setValue(data.title, forKey: "title")
            coreHabit.setValue(data.value, forKey: "value")
            coreHabit.setValue(data.uid, forKey: "uid")
            
            //print("dataStore:saveHabit:new")
            
            //InnerData
            let innerData = getManagedObjectToSet("YKInnerData")
            
            //print("get schedule entity, and type rawValue is \(habit.schedule.scheduleType.rawValue), days: \(habit.schedule.dayArrayToString())")
            innerData.setValue(data.innerData.title, forKey: "title")
            innerData.setValue(data.innerData.value, forKey: "value")
            innerData.setValue(data.uid, forKey: "dataUID")
            
            coreHabit.setValue(innerData, forKey: "innerData")
            
        }
        
        do{
            try managedContext.save()
            
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
            throw DataError.SavingError
        }
        
    }
    
    //MARK: - Utility
    
    //Generate unique id for store data entry
    //Using timeStamp + key (usually data title of some sort)
    //We never change this afterwards
    func generateHabitUid(key: String)->String{
        
        return "\(NSDate().timeIntervalSince1970 * 1000)-\(key)"
    }
    
    

}
