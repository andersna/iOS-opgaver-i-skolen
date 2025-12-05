//
//  Controller.swift
//  iDog
//
//  Created by dmu mac 29 on 24/09/2025.
//
import SwiftUI

@Observable
class DogController {
    var dogs: [Dog] = []
    var dogImages: [UIImage] = []
    
    func createDogs(){
        dogs = []
        dogImages = []
        Task{
            for _ in 0..<10{
                do {
                    let dog = try await FetchDog()
                    dogs.append(dog)
                } catch {
                    print("Error fetching dog: \(error)")
                }
            }
            getDogImages()
        }
    }
    
    func FetchDog() async throws -> Dog {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Dog.self, from: data)
    }
    
    func getDogImages() {
        Task {
            try await withThrowingTaskGroup(of: UIImage.self) { taskGroup in
                for dog in dogs {
                    taskGroup.addTask {
                        let (dogImageData, _) = try await URLSession.shared.data(from: dog.url)
                        return UIImage(data: dogImageData)!
                    }
                }
                for try await dogImageData in taskGroup{
                    dogImages.append(dogImageData)
                }
            }
        }
    }
}
