//
//  GoTController.swift
//  iGameOfThrones
//
//  Created by dmu mac 29 on 18/09/2025.
//
import SwiftUI

@Observable
class GoTController: Codable {
    var gotCharacters: [GoTCharacter] = []
    
    init(){
        Task(priority: .low){
            gotCharacters = await getGOTCharacters()
        }
    }
    
    func getGOTImage(url: URL) async -> UIImage?  {
        do{
            let data = try await NetworkService.getData(from: url)
            let image = UIImage(data: data)
            return image
        } catch{
            fatalError(error.localizedDescription)
        }
    }
    
    private func getGOTCharacters() async -> [GoTCharacter]{
        do {
            let data = try await NetworkService.getData(from: URL(string: "https://thronesapi.com/api/v2/Characters")!)
            let characters = try JSONDecoder().decode(
                [GoTCharacter].self,
                from: data
            )
            return characters
        } catch {
            print("Error decoding: \(error)")
            return []
        }
    }
}
