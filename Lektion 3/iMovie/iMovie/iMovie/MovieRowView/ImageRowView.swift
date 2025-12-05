//
//  ImageRowView.swift
//  iMovie
//
//  Created by dmu mac 29 on 26/08/2025.
//

import SwiftUI

struct ImageRowView: View {
    var poster: String
    var body: some View {
        Image(poster)
            .resizable()
            .frame(width: 70, height: 110)
            .shadow(color: .gray, radius: 10, x: 4, y: 4)
    }
}

#Preview {
    ImageRowView(poster: "Alita")
}
