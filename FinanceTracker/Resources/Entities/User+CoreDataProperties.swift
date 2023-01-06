//
//  User+CoreDataProperties.swift
//  FinanceTracker
//
//  Created by Богдан Конопольський on 28.12.2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var login: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var accounts: NSSet?

}

// MARK: Generated accessors for accounts
extension User {

    @objc(addAccountsObject:)
    @NSManaged public func addToAccounts(_ value: Account)

    @objc(removeAccountsObject:)
    @NSManaged public func removeFromAccounts(_ value: Account)

    @objc(addAccounts:)
    @NSManaged public func addToAccounts(_ values: NSSet)

    @objc(removeAccounts:)
    @NSManaged public func removeFromAccounts(_ values: NSSet)

}

extension User : Identifiable {

}
