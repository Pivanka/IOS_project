//
//  Transaction+CoreDataProperties.swift
//  FinanceTracker
//
//  Created by Богдан Конопольський on 28.12.2022.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var categoryValue: Int16
    @NSManaged public var dateCreated: Date?
    @NSManaged public var name: String?
    @NSManaged public var account: Account?
    
    var category : Category {
        get{
            return Category(rawValue: categoryValue) ?? .other
        }
        set{
            categoryValue = newValue.rawValue
        }
    }

}

extension Transaction : Identifiable {

}
