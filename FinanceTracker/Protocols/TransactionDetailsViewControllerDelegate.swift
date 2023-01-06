//
//  AddItemViewControllerDelegate.swift
//  FinanceTracker
//
//  Created by Богдан Конопольський on 17.12.2022.
//

import Foundation

protocol TransactionDetailsViewControllerDelegate: AnyObject
{
    func addItemViewControllerDidCancel(_ controller: TransactionDetailsTableViewController)
    func addTransactionViewController(_ controller: TransactionDetailsTableViewController, transactionDidAdded transactionToAdd: Transaction)
    func editTransactionViewController(_ controller: TransactionDetailsTableViewController, transactionDidEdited transactionToEdit: Transaction)
}
