//
//  AccountModel.swift
//  BankingApp
//
//  Created by dmu mac 29 on 11/09/2025.
//

import Foundation

@Observable
class AccountViewModel {
    var accounts = TestData.accounts
    
    func findIndexFor(account: Account) -> Int {
        return accounts.firstIndex{
            originalAccount in originalAccount.iban == account.iban
        }!
    }
    
    func generateDanishIBAN() -> String {
        let digits = (0..<16).map { _ in String(Int.random(in: 0...9)) }.joined()
        return "DK00\(digits)"
    }
    
    func createAccount(name: String, kind: Account.Kind){
        let iban = generateDanishIBAN()
        let newAccount = Account(name: name, iban: iban.ibanFormat, kind: kind)
        accounts.append(newAccount)
    }
    
    func createTransaction(withAmount amount: Int, beneficiary: String, to account: Account){
        let conversionTilOere = 100
        let transaction = Transaction(amount: amount * conversionTilOere, beneficiary: beneficiary, date: Date())
        accounts[findIndexFor(account: account)].add(transaction)
    }
    
    func moveAccount(from source: IndexSet, to destination: Int) {
        accounts.move(fromOffsets: source , toOffset: destination)
    }

}

struct Transaction: Identifiable, Hashable {
    var id = UUID()
    var amount: Int
    let beneficiary: String
    let date: Date
    
    var displayTransactionAmount: Int{
            let oereConvert = 100
            return amount / oereConvert
    }
}

struct Account: Identifiable, Hashable{
    let name: String
    let iban: String
    let kind: Kind
    private(set) var transactions: [Transaction]
    var id: String { iban }
    var balance: Int {
        transactions.reduce(0){ $0 + $1.amount}
    }
    
    var displayBalance: Int{
        let oereConvert = 100
        return balance / oereConvert
    }
    
    init(name: String, iban: String, kind: Kind) {
        self.name = name
        self.kind = kind
        self.iban = iban
        transactions = [ Transaction(
            amount: 200000,
            beneficiary: "Initial Balance",
            date: Date()) ]
    }
    mutating func add(_ transaction: Transaction) {
        transactions.append(transaction)
    }
}

extension Account {
    
    
    enum Kind: String, CaseIterable {
        case checking
        case savings
        case investment
        
        var displayName: String {
            switch self {
            case .checking: "Checking Account"
            case .savings: "Savings Account"
            case .investment: "Investment Account"
            }
        }
    }
}

struct TestData {
    static var accounts: [Account] = {
        var accounts = [
            Account(name: "Personal", iban: "0025QLKF901051019419".ibanFormat, kind: .checking),
            Account(name: "Savings", iban: "QV94TOUH552671475862".ibanFormat, kind: .savings)
        ]
        
        accounts[0].add(Transaction(amount: -50000, beneficiary: "Rent", date: Date()))
        accounts[0].add(Transaction(amount: -20000, beneficiary: "Groceries", date: Date()))
        return accounts
    }()
}
