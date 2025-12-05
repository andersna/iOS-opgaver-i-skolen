//
//  FirebaseService.swift
//  GasMeasurement
//
//  Created by dmu mac 29 on 19/11/2025.
//

import FirebaseFirestore

struct FirebaseService {

    private let db = Firestore.firestore()
    private let collection = "measurements"

    func listenToMeasurements(completion: @escaping ([GasMeasurement]) -> Void) {
        db.collection(collection)
            .order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error snapshot: \(error)")
                    return
                }

                guard let documents = snapshot?.documents else { return }

                let measurements = documents.compactMap { doc -> GasMeasurement? in
                    try? doc.data(as: GasMeasurement.self)
                }

                completion(measurements)
            }
    }

    func addMeasurement(_ measurement: GasMeasurement) {
        do {
            _ = try db.collection(collection).addDocument(from: measurement)
        } catch {
            print("Error saving: \(error)")
        }
    }

    func deleteMeasurement(id: String) {
        db.collection(collection).document(id).delete { error in
            if let error = error {
                print("Error deleting: \(error)")
            }
        }
    }
}
