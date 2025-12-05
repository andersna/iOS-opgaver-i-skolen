//
//  ContentView.swift
//  Animation
//
//  Created by dmu mac 29 on 27/11/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var rating: Int = 0

    var body: some View {
        HStack() {

            Button("Minus", systemImage: "minus.circle"){
                withAnimation{
                    rating -= 1
                }
            }
                .disabled(rating == 0)

            Text("\(rating)")
                .font(.system(size: 100, weight: .bold))
                .contentTransition(.numericText(value: Double(rating)))
            
            Button("Plus", systemImage: "plus.circle"){
                withAnimation{
                    rating += 1
                }
            }
                .disabled(rating == 10)
        }
        .padding()
    }
}




#Preview {
    ContentView()
}
