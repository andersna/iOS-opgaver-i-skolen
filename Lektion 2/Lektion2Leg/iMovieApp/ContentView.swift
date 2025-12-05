//
//  ContentView.swift
//  iMovieApp
//
//  Created by dmu mac 29 on 21/08/2025.
//

import SwiftUI

struct ContentView: View {
    let imageName: String
    let pets: [String]
    var body: some View {
        List{
            ForEach(pets, id: \.self){ pet in
                Text(pet)
            }
        }
    }
}

#Preview {
    ContentView(imageName: "person.circle", pets: ["mis", "mus", "fido"])
}

