//
//  LoginView.swift
//  YATDA
//
//  Created by dmu mac 29 on 20/11/2025.
//
import SwiftUI

struct LoginView: View {
    @Environment(AuthController.self) var authController

    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)

                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)

                if let errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                Button {
                    Task {
                        isLoading = true
                        let success = await authController.signInWithEmailPassword(email: email, password: password)
                        isLoading = false
                        if !success {
                            errorMessage = "Login failed"
                        } else {
                            errorMessage = nil
                        }
                    }
                } label: {
                    HStack {
                        if isLoading {
                            ProgressView()
                        } else {
                            Text("Sign In").bold()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.9))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .disabled(isLoading)

                NavigationLink("Need an account? Sign Up", destination: SignUp())
                    .padding(.top, 8)

                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if authController.user != nil {
                        Button {
                            authController.signOut()
                        } label: {
                            Label("Logout", systemImage: "power")
                        }
                    }
                }
            }
            .navigationTitle("Sign In")
        }
    }
}

