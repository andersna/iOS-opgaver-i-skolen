//
//  ActorView.swift
//  iMoviestars
//
//  Created by dmu mac 29 on 09/09/2025.
//

import SwiftUI

struct ActorView: View {
    var actor: Actor
    
    var body: some View {
        Image(actor.picture)
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .frame(width: 400, height: 400)
            .padding()
        Text(actor.name)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ActorView(actor: TestData.actors[1])
}
