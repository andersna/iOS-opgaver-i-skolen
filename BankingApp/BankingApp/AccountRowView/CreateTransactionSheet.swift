//
//  CreateTransactionSheet.swift
//  BankingApp
//
//  Created by dmu mac 29 on 12/09/2025.
//

import SwiftUI

struct CreateTransactionSheet: View {
    @Environment(AccountViewModel.self) private var accountViewModel
    @State private var amount: String = ""
    @State private var beneficiary: String = ""
    @Binding var account: Account
    @Binding var showingCreateTransactionSheet: Bool
    @FocusState private var transactionAmountFocus: Bool
    
    var body: some View {
        NavigationStack{
            Form{
                HStack{
                    Text("Amount: ").font(.subheadline)
                    Spacer()
                    TextField("", text: $amount).focused($transactionAmountFocus)
                        .multilineTextAlignment(.trailing).font(.subheadline)
                    Text("kr.")
                }
                TextField("Beneficiary", text: $beneficiary).font(.subheadline)
            }.navigationTitle("Create Transaction")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel"){
                            showingCreateTransactionSheet = false
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Send"){
                            if let amountInt = Int(amount){
                                accountViewModel.createTransaction(withAmount: amountInt, beneficiary: beneficiary, to: account)
                             showingCreateTransactionSheet = false
                            }
                              
                            
                        }
                    }
                }
        }.onAppear(){
            transactionAmountFocus = true
        }
    }
}

#Preview {
    @Previewable @State var x = true
    @Previewable @State var account = TestData.accounts[0]
    NavigationStack{
        CreateTransactionSheet(account: $account, showingCreateTransactionSheet: $x).environment(AccountViewModel())
    }
}

