//
//  iMoviestarsApp.swift
//  iMoviestars
//
//  Created by dmu mac 29 on 09/09/2025.
//

import SwiftUI

@main
struct iMoviestarsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environment(ActorViewModel())
        }
    }
}
