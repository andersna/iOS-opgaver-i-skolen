//
//  ContentView.swift
//  iMoviestars
//
//  Created by dmu mac 29 on 09/09/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(ActorViewModel.self) private var viewModel
    @State private var navigationPath : [Actor] = []
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List{
                ForEach(viewModel.Actors) { actor in
                    NavigationLink(value: actor){
                        RowView(actor: actor)
                    }
                }
            }.navigationTitle("Actors")
             .navigationDestination(for: Actor.self) { actor in
                ActorView(actor: actor)
            }
        }
    }
}

#Preview {
    ContentView().environment(ActorViewModel())
}
