//
//  Writer.swift
//  Persistering
//
//  Created by dmu mac 29 on 23/10/2025.
//

import Foundation
import SwiftUI

struct Writer {
    static func write<T>(_ object: T, to file: String) {
        guard let homeFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let path = homeFolder.appendingPathComponent(file)

        do {
            if let data = object as? Data {
                try data.write(to: path)
            } else if let encodable = object as? Encodable {
                let data = try JSONEncoder().encode(encodable)
                try data.write(to: path)
            } else {
                print("Unsupported type: \(T.self)")
            }
            print("Saved to: \(path)")
        } catch {
            print("Could not write file \(path): \(error)")
        }
    }
}
