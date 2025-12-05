//
//  iDogApp.swift
//  iDog
//
//  Created by dmu mac 29 on 24/09/2025.
//

import SwiftUI

@main
struct iDogApp: App {
    @State var controller = DogController()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(controller)
        }
    }
}
