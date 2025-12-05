//
//  GasMeasurementApp.swift
//  GasMeasurement
//
//  Created by dmu mac 29 on 19/11/2025.
//

import SwiftUI
import FirebaseCore

@main
struct GasMeasurementApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            GasMeasurementListView()
        }
    }
}
