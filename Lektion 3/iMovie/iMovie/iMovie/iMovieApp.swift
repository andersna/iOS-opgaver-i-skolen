//
//  iMovieApp.swift
//  iMovie
//
//  Created by dmu mac 29 on 26/08/2025.
//

import SwiftUI

@main
struct iMovieApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(MovieViewModel())
        }
    }
}
