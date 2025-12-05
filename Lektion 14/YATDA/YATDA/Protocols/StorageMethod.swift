//
//  DBProtocol.swift
//  YATDA
//
//  Created by dmu mac 29 on 30/10/2025.
//
import Foundation

/// StorageMethod
/// Implementering af Dependency Inversion Principle i SOLID &
/// Interface Segregation Principle fra SOLID
protocol StorageMethod {
    func create<T: Codable & Identifiable & FireStoreEntity>(element: T) throws
    //func retrieve<T: Codable & Identifiable>(_ id: T.ID) throws -> T? where T.ID == String?
    func update<T: Codable & Identifiable & FireStoreEntity>(_ element: T) throws where T.ID == String?
    func delete<T: Identifiable & FireStoreEntity>(_ element : T) async throws where T.ID == String?
}

/// StorageListner
/// Implementering af Dependency Inversion Principle i SOLID &
/// Interface Segregation Principle fra SOLID
protocol StorageListner {
    func subscribe<T:Codable & FireStoreEntity>(onChange: @escaping ([T]) -> Void)
    func unsubscribe()
}
