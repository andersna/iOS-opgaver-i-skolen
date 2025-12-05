//
//  SignUpView.swift
//  YATDA
//
//  Created by dmu mac 29 on 20/11/2025.
//
import SwiftUI

struct SignUp: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @Environment(AuthController.self) var authController

    var body: some View {
        Form {
            Section {
                TextField("Email", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .keyboardType(.default)
            }
            Section {
                Button( action: {
                    Task{
                        await authController.signUpWithEmailPassword(
                            email: emailAddress,
                            password: password)
                    }
                },
                        label: {
                    Text("Sign Up")
                        .bold()
                })
            }
        }.navigationTitle("Sign Up")
    }
}

#Preview {
    SignUp().environment(AuthController())
}

