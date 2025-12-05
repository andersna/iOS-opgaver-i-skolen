//
//  AccountInfoView.swift
//  BankingApp
//
//  Created by dmu mac 29 on 11/09/2025.
//

import SwiftUI

struct AccountInfoView: View {
    var account: Account
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack{
                Text(account.name).font(.headline)
                Spacer()
                Text(account.displayBalance, format: .currency(code: "DKK"))
                                    .fontWeight(.bold)
            }
            Text(account.kind.displayName).font(.subheadline).foregroundStyle(.secondary)
            Text(account.iban)
                .font(.caption)
                .foregroundStyle(.secondary)
            
        }
    }
}

#Preview {
    AccountInfoView(account: TestData.accounts[0])
}
