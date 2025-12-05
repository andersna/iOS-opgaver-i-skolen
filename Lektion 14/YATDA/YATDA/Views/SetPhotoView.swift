//
//  SetPhotoView.swift
//  YATDA
//
//  Created by dmu mac 29 on 25/11/2025.
//

import SwiftUI
import PhotosUI

struct SetPhotoView: View {
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    var profileImage: Image{
        guard let data = selectedImageData, let image = UIImage(data: data) else {
            return Image(systemName: "person.crop.circle")
        }
        return Image(uiImage: image)
    }
    
    var body: some View {
        VStack {
            profileImage
                .resizable()
                .frame(width: 250, height: 250)
                .background(Color.black.opacity(0.2))
                .clipShape(Circle())
            
            PhotosPicker(
                selection: $selectedPhoto,
                matching: .images,
                photoLibrary: .shared()
            ){
                Label("Select Image", systemImage: "photo")
            }
            .onChange(of: selectedPhoto) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        self.selectedImageData = data
                    }
                }
            }
        }
    }
}

#Preview {
    SetPhotoView()
}
