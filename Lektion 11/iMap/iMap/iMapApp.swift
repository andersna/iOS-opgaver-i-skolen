//
//  iMapApp.swift
//  iMap
//
//  Created by dmu mac 29 on 02/10/2025.
//

import SwiftUI
import MapKit

@main
struct iMapApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView().environment(Controller())
        }
    }
}
