//
//  StringExtension.swift
//  BankingApp
//
//  Created by dmu mac 29 on 11/09/2025.
//

import Foundation
extension String {
    var ibanFormat: String {
        var remaining = Substring(self)
        var chunks: [Substring] = []
        while !remaining.isEmpty {
            chunks.append(remaining.prefix(4))
            remaining = remaining.dropFirst(4)
        }
        return chunks.joined(separator: " ")
    }
}
