//
//  FirebaseService.swift
//  YATDA
//
//  Created by dmu mac 29 on 30/10/2025.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirebaseStorage: StorageMethod {

    private let dbRef = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?

    func create<T:Codable & FireStoreEntity>(element: T) throws {
        try dbRef
            .collection(T.collectionName)
            .addDocument(from: element)
    }

    func update<T: Codable & Identifiable & FireStoreEntity>(_ element: T) throws where T.ID == String? {
        guard let documentID = element.id else { return }
        try dbRef
            .collection(T.collectionName)
            .document(documentID)
            .setData(from: element)
    }

    func delete<T:Identifiable & FireStoreEntity>(_ element:T) async throws where T.ID == String? {
        guard let id = element.id else { return }
        try await dbRef
            .collection(T.collectionName)
            .document(id)
            .delete()
    }
}

/// Firebase StorageListner implementation
/// not all db implementations support realtime communication between client & server
/// so in order to ahear to SOLID principle I - Interface Segregation Principle this is done in
/// another protocol and seperated in an extension for readability
extension FirebaseStorage: StorageListner {

    func subscribe<T: Codable & FireStoreEntity>(onChange: @escaping ([T]) -> Void) {
        listenerRegistration = dbRef
            .collection(T.collectionName)
            .addSnapshotListener{ querySnapshot, error in
                guard let documents = querySnapshot?.documents else {return}
                let elements = documents.compactMap { queryDocumentSnapshot in
                    return try? queryDocumentSnapshot.data(as: T.self)
                }
                onChange(elements)
            }
    }

    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func findUser(withEmail email: String) async -> Bool {
        do{
            let snapshot = try await dbRef.collection("Users").whereField("email", isEqualTo: email).getDocuments()
            return !snapshot.isEmpty
        } catch{
            print(error.localizedDescription)
            return false
        }
    }
}
