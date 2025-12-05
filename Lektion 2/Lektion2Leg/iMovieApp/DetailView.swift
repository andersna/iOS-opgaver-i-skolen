//
//  PetDetailView.swift
//  iMovieApp
//
//  Created by dmu mac 29 on 21/08/2025.
//

import SwiftUI

struct DetailView: View {
    let imageName: String
    var body: some View {
        VStack(){
            ZStack(alignment: .bottomLeading){
                Image(imageName)
                    .resizable()
                    .card()
                HStack{
                    Text("Madrid")
                        .font(.largeTitle).foregroundStyle(.white).bold()
                        .padding(10)
                    Spacer()
                    Button("Info"){
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .padding(10)
                }
            }
            .padding()
            Spacer()
        }
    }
}
    
    #Preview {
        DetailView(imageName: "Madrid")
    }

struct CardModifier: ViewModifier{
    let imageName: String
    func body(content: Content) -> some View{
        content
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
    }
}
    
extension View{
    func card()-> some View{
        modifier(CardModifier(imageName: "Madrid"))
    }
}
