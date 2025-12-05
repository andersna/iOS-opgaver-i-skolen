//
//  BankingAppApp.swift
//  BankingApp
//
//  Created by dmu mac 29 on 11/09/2025.
//

import SwiftUI

@main
struct BankingAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(AccountViewModel())
        }
    }
}
