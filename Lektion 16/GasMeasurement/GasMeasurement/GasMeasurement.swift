//
//  GasMeasurement.swift
//  GasMeasurement
//
//  Created by dmu mac 29 on 19/11/2025.
//

import FirebaseFirestore

struct GasMeasurement: Identifiable, Codable {
    @DocumentID var id: String?
    var date: Date
    var measurement: Int
}
