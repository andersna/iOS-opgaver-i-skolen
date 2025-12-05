// YATDAApp.swift
// Project: YATDA 
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 29/10/2025 at 11.06.
// Copyright © 2025 ksd. All rights reserved.
//
// 

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct YATDAApp: App {

    init(){
        FirebaseApp.configure()
        let storageService = FirebaseStorage()
        controller = .init(
            storageService: storageService,
            storageListner: storageService
        )
        auth = .init()
    }

    @State private var controller: ReminderController
    @State private var auth: AuthController

    var body: some Scene {
        WindowGroup {
            ContentView()
                .navigationTitle("Reminders")
                .environment(controller).environment(auth)
        }
    }

}
