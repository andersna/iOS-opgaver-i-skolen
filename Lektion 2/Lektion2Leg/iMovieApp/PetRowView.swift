//
//  PetRowView.swift
//  iMovieApp
//
//  Created by dmu mac 29 on 21/08/2025.
//

import SwiftUI

struct PetRowView: View {
    let imageName: String
    let pet: String
    var body: some View {
        HStack{
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .clipShape(Circle())
            Spacer()
            Text(pet)
        }
        .padding()
    }
}

#Preview {
    PetRowView(imageName: "missekat", pet: "mis")
}
