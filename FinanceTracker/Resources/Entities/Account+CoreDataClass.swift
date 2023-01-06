//
//  Account+CoreDataClass.swift
//  FinanceTracker
//
//  Created by Богдан Конопольський on 28.12.2022.
//
//

import Foundation
import CoreData

@objc(Account)
public class Account: NSManagedObject {

    convenience init() {
        
        
        self.init(entity: DataManager.shared.entityForName(entityName: "Account"), insertInto: DataManager.shared.persistentContainer.viewContext)
    }
}
