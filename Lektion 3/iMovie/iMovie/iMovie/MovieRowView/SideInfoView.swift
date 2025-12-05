//
//  SideInfoView.swift
//  iMovie
//
//  Created by dmu mac 29 on 26/08/2025.
//

import SwiftUI

struct SideInfoView: View {
    let title: String
    let director: String
    let genre: String
    let runtime: String
    let isFavorite: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            HStack{
                Text(title)
                    .font(.headline)
                Spacer()
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundStyle(.yellow)
            }
            Text(director)
                .font(.subheadline)
            Group{
                Text(genre)
                Text(runtime)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SideInfoView(title: TestData.movies[0].title,
                 director: TestData.movies[0].director,
                 genre: TestData.movies[0].genre,
                 runtime: TestData.movies[0].runtime, isFavorite: TestData.movies[0].isFavorite)
}
