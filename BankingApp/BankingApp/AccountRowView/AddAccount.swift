//
//  AddAccount.swift
//  BankingApp
//
//  Created by dmu mac 29 on 12/09/2025.
//

import SwiftUI

struct AddAccount: View {
    @Environment(AccountViewModel.self) var accountViewModel
    @State private var name: String = ""
    @State private var kind: Account.Kind = Account.Kind.checking
    @Binding var showingAddAccountSheet: Bool
    @FocusState private var isNameFocused: Bool
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Account name", text: $name).focused($isNameFocused)
                Picker("Kind", selection: $kind){
                    ForEach(Account.Kind.allCases, id:\.self){
                        kindCase in Text(kindCase.rawValue).tag(kindCase)
                    }
                }
            }.navigationTitle("New Account")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel"){
                            showingAddAccountSheet = false
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Create"){
                            accountViewModel.createAccount(name: name, kind: kind)
                            showingAddAccountSheet = false
                        }
                    }
                }
        }.onAppear(){
            isNameFocused = true
        }
    }
}

#Preview {
    @Previewable @State var x = true
    NavigationStack{
        AddAccount(showingAddAccountSheet: $x).environment(AccountViewModel())
    }
}
