//
//  TransactionInfoView.swift
//  BankingApp
//
//  Created by dmu mac 29 on 12/09/2025.
//

import SwiftUI

struct TransactionInfoView: View {
    var trans: Transaction
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
                    HStack{
                        Text(trans.beneficiary).font(.headline)
                        Spacer()
                        Text(trans.displayTransactionAmount, format: .currency(code: "DKK")).font(.subheadline)
                    }
                    Text(trans.date.transactionFormat).font(.subheadline).foregroundStyle(.secondary)
            }
        }
    }


#Preview {
    TransactionInfoView(trans: TestData.accounts[0].transactions[0])
}
