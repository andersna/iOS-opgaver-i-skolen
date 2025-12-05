//
//  ContentView.swift
//  BankingApp
//
//  Created by dmu mac 29 on 11/09/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.editMode) private var editMode
    @Environment(AccountViewModel.self) var accountViewModel
    @State private var navigationPath : [Account] = []
    @State private var showingAddAccountSheet : Bool = false
    
    var body: some View {
        @Bindable var viewModel = accountViewModel
        NavigationStack(path: $navigationPath) {
            List {
                ForEach($viewModel.accounts) { $account in NavigationLink(value: account){
                    AccountInfoView(account: account)
                    }
                }
                .onMove(perform: accountViewModel.moveAccount)
            }.navigationDestination(for: Account.self){ theAccount in
                AccountDetailView(account: $viewModel.accounts[viewModel.findIndexFor(account: theAccount)])
                
            }
            .sheet(isPresented: $showingAddAccountSheet){
                AddAccount(showingAddAccountSheet: $showingAddAccountSheet)
            }
            
            .navigationTitle("Accounts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingAddAccountSheet = true
                    } label: {
                        Label("Add Account", systemImage: "plus.circle.fill").labelStyle(.titleAndIcon).frame(maxWidth: .infinity)
                    }.buttonStyle(.plain)
                        .buttonBorderShape(.capsule)
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(AccountViewModel())
}
