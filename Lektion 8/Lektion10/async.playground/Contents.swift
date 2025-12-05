import Foundation

let randomUserURL = URL(
    string: "https://randomuser.me/api/?results=10&nat=dk"
)!

func fetchData(from url: URL) async throws -> Data {
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse else { fatalError("Bad Response") }
    if httpResponse.statusCode != 200 {
        fatalError("Bad Status Code: \(httpResponse.statusCode)")
    }
    return data
}

Task{
    do{
        let data = try await fetchData(from: randomUserURL)
        let users = try JSONDecoder().decode(RandomUserResults.self, from: data)
    } catch {
        fatalError(error.localizedDescription)
    }
}

struct RandomUserResults: Codable {
    let results: [RandomUser]
}

struct RandomUser: Codable{
    let name: Name
    let picture: Picture
    let login: Login
    
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }
    
    struct Picture: Codable {
        let large: URL
        let medium: URL
    }
    
    struct Login: Codable{
        let username: String
        let uuid: String
    }
}


