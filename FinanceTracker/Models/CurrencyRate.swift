//
//  CurrencyRate.swift
//  FinanceTracker
//
//  Created by Богдан Конопольський on 04.01.2023.
//

import Foundation


struct CurrencyRateResponseResultModel : Codable {
    
    let currencyCodeA: Int32?
    let currencyCodeB: Int32?
    let date: Int64?
    let rateSell: Float?
    let rateBuy: Float?
    let rateCross: Float?
}

struct CurrencyCodes
{
    static let codes = [840: CurrencyRepresentation(code: "USD", icon: "🇺🇸"),
                        980: CurrencyRepresentation(code: "UAH", icon: "🇺🇦"),
                        978: CurrencyRepresentation(code: "EUR", icon: "🇪🇺")]
}

struct CurrencyRepresentation
{
    
    var code: String
    var icon: String
    
    init(code: String, icon: String) {
       self.code = code
       self.icon = icon
   }
}
