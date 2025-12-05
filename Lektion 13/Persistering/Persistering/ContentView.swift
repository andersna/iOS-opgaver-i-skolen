//
//  ContentView.swift
//  Persistering
//
//  Created by dmu mac 29 on 23/10/2025.
//

import SwiftUI

struct ContentView: View {
    let newAvatar = UIImage(named: "halo.jpg")
    @State private var readImage: UIImage = UIImage()

    var body: some View {
        VStack {
            Image(uiImage: newAvatar ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            Image(uiImage: readImage)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            Button("Save") {
                if let imageData = newAvatar?.pngData() {
                    Writer.write(imageData, to: "imageData.png")
                }
            }

            Button("Read") {
                let homeFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                if let path = homeFolder?.appendingPathComponent("imageData.png"),
                   let data = try? Data(contentsOf: path),
                   let image = UIImage(data: data) {
                    readImage = image
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
