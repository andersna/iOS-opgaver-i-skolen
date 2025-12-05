//
//  MarkerView.swift
//  iMap
//
//  Created by dmu mac 29 on 23/10/2025.
//

import SwiftUI
import MapKit

struct MarkerView: View {
    let user: RandomUser
    let controller: Controller
    @State private var img: UIImage?
    
    var body: some View {
        VStack {
            if let img {
                Image(uiImage: img)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
        }
        .task {
            img = await controller.fetchImage(for: user)
        }
    }
}

#Preview {
    MarkerView(user: RandomUser.dummyUser, controller: Controller())
}
