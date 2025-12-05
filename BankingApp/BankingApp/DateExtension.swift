//
//  DateExtension.swift
//  BankingApp
//
//  Created by dmu mac 29 on 11/09/2025.
//

import Foundation

extension Date {
    var transactionFormat: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
