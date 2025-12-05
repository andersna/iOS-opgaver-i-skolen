//
//  ContentView.swift
//  iDog
//
//  Created by dmu mac 29 on 24/09/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(DogController.self) var controller: DogController
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(controller.dogImages, id: \.self){ dog in
                    Image(uiImage: dog)
                        .resizable()
                        .scaledToFit()
                }
            }.navigationTitle("Dogs")
        }.task {
            do{
                controller.createDogs()
            }
        }.refreshable{
            controller.createDogs()
        }
    }
}

#Preview {
    ContentView().environment(DogController())
}
