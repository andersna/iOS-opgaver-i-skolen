//
//  JamesBondModel.swift
//  iMoviestars
//
//  Created by dmu mac 29 on 09/09/2025.
//

import Foundation

struct Actor: Identifiable, Hashable
{
    let id = UUID()
    let name: String
    let picture: String
}

@Observable
class ActorViewModel{
    var Actors = TestData.actors
}

struct TestData{
    static var actors = [
        Actor(name: "Daniel Craig",
              picture: "daniel_craig"),
        
        Actor(name: "George Lazenby",
              picture: "george_lazenby"),
        
        Actor(name: "Pierce Brosnan",
              picture: "pierce_brosnan"),
        
        Actor(name: "Roger Moore",
              picture: "roger_moore"),
        
        Actor(name: "Sean Connery",
              picture: "sean_connery"),
        
        Actor(name: "Timothy Dalton",
              picture: "timothy_dalton")
    ]
}
