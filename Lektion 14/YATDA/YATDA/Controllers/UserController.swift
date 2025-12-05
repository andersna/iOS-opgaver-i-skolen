//
//  UserController.swift
//  YATDA
//
//  Created by dmu mac 29 on 25/11/2025.
//
import FirebaseAuth

class UserController {
    
    private let firestore = FirebaseStorage()
    
    func createUserIfNeeded(user: User) {
        Task{
            if let email = user.email{
                if await firestore.findUser(withEmail: email){
                    print("User already exists -> no need to create again.")
                    return
                } else {
                    print("Creating new user document...")
                    let appUser = AppUser(
                        userName: user.displayName ?? "",
                        email: user.email ?? "",
                        profileImage: nil
                    )
                    do {
                        try firestore.create(element: appUser)
                    } catch {
                        print("Could not create user document: \(error)")
                    }
                }
            }
        }
    }
    
    
    func updateUser(_ user: AppUser) {
        do {
            try firestore.update(user)
        } catch {
            print(" Could not update user: \(error)")
        }
    }
}
