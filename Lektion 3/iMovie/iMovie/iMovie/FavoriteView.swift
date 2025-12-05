//
//  FavoriteView.swift
//  iMovie
//
//  Created by dmu mac 29 on 28/08/2025.
//

import SwiftUI

struct FavoriteView: View {
    @Binding var isSet: Bool
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .font(.largeTitle)
                .foregroundStyle(.yellow)
        }
    }
}

#Preview {
    Group{
        FavoriteView(isSet: .constant(true))
        FavoriteView(isSet: .constant(false))
    }
}
