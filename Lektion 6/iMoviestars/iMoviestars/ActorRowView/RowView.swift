//
//  ImageRowView.swift
//  iMoviestars
//
//  Created by dmu mac 29 on 09/09/2025.
//

import SwiftUI

struct RowView: View {
    var actor: Actor
    
    var body: some View {
        HStack(spacing: 20){
            Image(actor.picture)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .shadow(color: .gray, radius: 10, x: 4, y: 4)
            Text(actor.name)
        }
    }
}

#Preview {
    RowView(actor: TestData.actors[0])
}
