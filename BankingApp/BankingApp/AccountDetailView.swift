//
//  AccountDetailView.swift
//  BankingApp
//
//  Created by dmu mac 29 on 11/09/2025.
//

import SwiftUI

struct AccountDetailView: View {
    @Environment(AccountViewModel.self) var accountViewModel
    @Binding var account: Account
    @State private var showingCreateTransactionSheet = false
    @State private var selectedTransaction: Transaction?
    @State private var showingDeleteConfirmationDialog = false
    
    var body: some View {
        @Bindable var viewModel = accountViewModel
            List {
                ForEach(account.transactions.reversed()){ trans in
                    TransactionInfoView(trans: trans)
                }
            }
            .sheet(isPresented: $showingCreateTransactionSheet){
                CreateTransactionSheet(account: $viewModel.accounts[viewModel.findIndexFor(account: account)], showingCreateTransactionSheet: $showingCreateTransactionSheet)
            }
            .navigationTitle(account.name)
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingCreateTransactionSheet = true
                    } label: {
                        Label("New Transaction", systemImage: "plus.circle.fill").labelStyle(.titleAndIcon).frame(maxWidth: .infinity)
                    }.buttonStyle(.plain)
                        .buttonBorderShape(.capsule)
                        .padding(.horizontal)
                }
            }
    }
}

#Preview {
    @Previewable @State var account: Account = TestData.accounts[0]
    NavigationStack{
        AccountDetailView(account: $account).environment(AccountViewModel())
    }
}
