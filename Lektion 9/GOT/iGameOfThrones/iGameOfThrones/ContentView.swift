//
//  ContentView.swift
//  iGameOfThrones
//
//  Created by dmu mac 29 on 18/09/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(GoTController.self) var controller
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    ForEach(controller.gotCharacters){ character in
                        NavigationLink(value: character){
                            Text(character.fullName)
                        }
                    }
                }
            }.navigationDestination(for: GoTCharacter.self) { character in
                GotView(character: character)
            }
        }
    }
}

#Preview {
    ContentView().environment(GoTController())
}
