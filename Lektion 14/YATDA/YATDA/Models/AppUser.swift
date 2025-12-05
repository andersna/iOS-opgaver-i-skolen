//
//  User.swift
//  YATDA
//
//  Created by dmu mac 29 on 20/11/2025.
//

import Foundation
import FirebaseFirestore

struct AppUser: Codable, Identifiable, FireStoreEntity{
    @DocumentID var id: String?
    let userName: String
    let email: String
    let profileImage: Data?
    static let collectionName = "Users"
}
