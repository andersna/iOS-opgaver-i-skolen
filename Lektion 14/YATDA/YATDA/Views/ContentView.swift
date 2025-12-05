// ContentView.swift
// Project: YATDA 
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 29/10/2025 at 11.06.
// Copyright © 2025 ksd. All rights reserved.
//
// 

import SwiftUI

struct ContentView: View {

    @Environment(ReminderController.self) var controller
    @Environment(AuthController.self) var authController
    
    @State private var isAddReminderDialogPresented = false

    private func presentAddReminderView() {
        isAddReminderDialogPresented.toggle()
    }
    
    var body: some View {
        @Bindable var controller = controller
        @Bindable var auth = authController
        if auth.authenticationState == .authenticated{
            List {
                ForEach($controller.reminders) { $reminder in
                    HStack {
                        Image(systemName: reminder.isCompleted
                              ? "largecircle.fill.circle"
                              : "circle")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .onTapGesture {
                            reminder.isCompleted.toggle()
                            controller.updateReminder(reminder)
                        }
                        Text(reminder.title)
                        BellView(isNotified: $reminder.isCompleted)
                    }
                }
                .onDelete { indexSet in
                    let reminder = self.controller.reminders[indexSet.first!]
                    controller.deleteReminder(reminder)
                }
            }.navigationTitle("To Do'S")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: presentAddReminderView) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New Reminder")
                        }
                    }
                    Spacer()
                    Button("Log Out") {
                        authController.signOut()
                    }
                }
            }
            .sheet(isPresented: $isAddReminderDialogPresented) {
                AddReminderView{ reminder in
                    controller.addReminder(reminder)
                }
            }
        } else {
            LoginView()
        }
    }
}

#Preview {
    @Previewable @State var storageService = FirebaseStorage()
    @Previewable @State var authService = AuthController()
    ContentView()
        .environment(ReminderController(
            storageService: storageService,
            storageListner: storageService)
        ).environment(authService)
}

