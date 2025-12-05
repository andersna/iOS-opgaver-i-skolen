//
//  AuthStateController.swift
//  YATDA
//
//  Created by dmu mac 29 on 20/11/2025.
//

import Foundation
import FirebaseAuth

enum AuthenticationState {
    case unauthenticated
    case authenticated
    case authenticating
}

@Observable
class AuthController {

    let userService = UserController()
    var authenticationState: AuthenticationState = .unauthenticated
    var user: User?
    var displayName = ""
    @ObservationIgnored
    var authStateHandler: AuthStateDidChangeListenerHandle?

    init(){
        registerAuthStateHandler()
    }
    
    
    @MainActor
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { (auth, user) in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.displayName ?? "Anonymous"
                
                if let user {
                    self.userService.createUserIfNeeded(user: user)
                }
            }
        }
    }

    func signInWithEmailPassword(email: String, password: String) async -> Bool{
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            return true
        } catch {
            print("Error signing in: \(error.localizedDescription)")
            return false
        }
    }

    func signUpWithEmailPassword(email: String, password: String) async {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
        } catch {
            print("Error signing up: \(error.localizedDescription)")
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    func deleteAccount() async {
        do {
            try await user?.delete()
        } catch {
            print("Error Deleting Account: \(error.localizedDescription)")
        }
    }

}
