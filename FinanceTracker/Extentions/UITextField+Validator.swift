//
//  UITextField+Validator.swift
//  FinanceTracker
//
//  Created by Богдан Конопольський on 03.01.2023.
//

import Foundation
import UIKit

extension UITextField
{
    func isEmpty() -> Bool
    {
        guard let text = self.text,
              !text.isEmpty else {
            return false
        }
        
        return true
    }
}
