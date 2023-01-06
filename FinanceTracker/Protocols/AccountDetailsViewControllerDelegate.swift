//
//  AccountDetailsViewControllerDelegate.swift
//  FinanceTracker
//
//  Created by Богдан Конопольський on 19.12.2022.
//

import Foundation

protocol AccountDetailsViewControllerDelegate : AnyObject {
    func accountDetailsViewControllerDidCancel(_ controller: AccountDetailsViewController)
    func accountDetailsViewController(_ controller: AccountDetailsViewController, didFinishAdding account: Account)
    func accountDetailsViewController(_ controller: AccountDetailsViewController, didFinishEditing account: Account)
}
