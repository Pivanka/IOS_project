//
//  DataManager.swift
//  FinanceTracker
//
//  Created by Богдан Конопольський on 22.12.2022.
//

import Foundation
import CoreData

class DataManager
{
    // MARK: - Singleton
    static let shared = DataManager()
    
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: persistentContainer.viewContext)!
    }
    
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - Add
    
    func transaction(name: String, amount: Decimal, dateCreated: Date, category: Category, account: Account) -> Transaction {
        
        let transaction = Transaction(context: persistentContainer.viewContext)
        
        transaction.name = name
        transaction.amount = (amount) as NSDecimalNumber
        transaction.dateCreated = dateCreated
        transaction.category = category
        transaction.account = account
        
        account.addToTransactions(transaction)
        
        return transaction
    }
    
    func transaction(name: String, amount: Decimal, dateCreated: Date, category: Category) -> Transaction
    {
        let transaction = Transaction(context: persistentContainer.viewContext)
        
        transaction.name = name
        transaction.amount = (amount) as NSDecimalNumber
        transaction.dateCreated = dateCreated
        transaction.category = category
        
        return transaction
    }
    
    func account(name: String, user: User) -> Account
    {
        let account = Account(context: persistentContainer.viewContext)
        
        account.name = name
        account.user = user
        
        user.addToAccounts(account)
        
        return account
    }
    
    func account(name: String) -> Account
    {
        let account = Account(context: persistentContainer.viewContext)
        
        account.name = name
        
        return account
    }
    
    func user(name: String, login: String, password: String) -> User
    {
        let user = User(context: persistentContainer.viewContext)
        
        user.name = name
        user.login = login
        user.password = password
        
        return user
    }
    
    //MARK: - GET
    
    func getTransactions(account: Account) -> [Transaction]
    {
        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        
        var fetchedTransactions:[Transaction] = []
        
        request.predicate = NSPredicate(format: "account = %@", account)
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: true)]
        do{
            
            fetchedTransactions = try
            persistentContainer.viewContext.fetch(request)
            
        }
        catch let error
        {
            print("Error fetching transactions \(error)")
        }
        
        
        return fetchedTransactions
    }
    
    func getUserAccounts(user: User) -> [Account]
    {
        var fetchedAccounts:[Account] = []
        let request: NSFetchRequest<Account> = Account.fetchRequest()
        
        request.predicate = NSPredicate(format: "user = %@", user)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do{
            fetchedAccounts = try persistentContainer.viewContext.fetch(request)
        }
        catch let error {
            print("Error fetching accounts \(error)")
        }
        return fetchedAccounts
    }
    
//    func getAccountSpendings(account: Account) -> [Transaction]
//    {
//        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()
//        
//        var fetchedTransactions:[Transaction] = []
//        
//        request.predicate = NSPredicate(format: "amount < %@", NSDecimalNumber(value: 0))
//        
//        do{
//            
//            fetchedTransactions = try
//            persistentContainer.viewContext.fetch(request)
//            
//        }
//        catch let error
//        {
//            print("Error fetching transactions \(error)")
//        }
//        
//        
//        return fetchedTransactions.reduce(0, {$0.})
//    }
    
    func getAllAccounts() -> [Account]
    {
        var fetchedAccounts:[Account] = []
        let request: NSFetchRequest<Account> = Account.fetchRequest()
        
        do{
            fetchedAccounts = try persistentContainer.viewContext.fetch(request)
        }
        catch let error {
            print("Error fetching accounts \(error)")
        }
        return fetchedAccounts
    }
    
    func getUsers() -> [User]
    {
        var fetchedUsers:[User] = []
        
        let request:NSFetchRequest<User> = User.fetchRequest()
        
        do{
            fetchedUsers = try persistentContainer.viewContext.fetch(request)
        }
        
        catch let error {
            print("Error fetching users \(error)")
        }
        
        return fetchedUsers
    }
    
    //MARK: - Delete
    
    func deleteTransaction(transaction: Transaction)
    {
        let context = persistentContainer.viewContext
        
        context.delete(transaction)
        
        save()
    }
    
    func deleteAccount(account: Account)
    {
        let context = persistentContainer.viewContext
        
        context.delete(account)
        
        save()
    }
    
    func deleteUser(user: User)
    {
        let context = persistentContainer.viewContext
        context.delete(user)
        save()
    }
}
