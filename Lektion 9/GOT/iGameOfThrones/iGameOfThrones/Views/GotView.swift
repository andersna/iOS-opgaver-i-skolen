//
//  GotView.swift
//  iGameOfThrones
//
//  Created by dmu mac 29 on 18/09/2025.
//

import SwiftUI

struct GotView: View {
    @Environment(GoTController.self) var controller
    @State private var image: UIImage?
    let character: GoTCharacter
    
    var body: some View {
        VStack{
            Text(character.fullName)
            Text(character.family)
            Text(character.title)
            if let image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(width: 300)
        .cornerRadius(20)
        .onAppear{
            Task{
                image = await controller.getGOTImage(url: character.imageUrl)
            }
        }
    }
}

#Preview {
    GotView(
        character: GoTCharacter(id: 1, firstName: "Daenerys", lastName: "Andersen", fullName: "Daenerys Andersen", title: "mrs", family: "andersen", imageUrl: URL(string: "https://thronesapi.com/assets/images/daenerys.jpg")!)).environment(GoTController())
}

