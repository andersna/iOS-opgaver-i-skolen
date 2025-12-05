//
//  AddMeasurementSheet.swift
//  GasMeasurement
//
//  Created by dmu mac 29 on 19/11/2025.
//

import SwiftUI

struct AddMeasurementSheet: View {

    @Environment(\.dismiss) var dismiss
    @State private var value: String = ""
    var controller: GasMeasurementController

    var body: some View {
        NavigationStack {
            Form {
                Section("Ny måling") {
                    TextField("Forbrug (m3)", text: $value)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Tilføj måling")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Luk") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Gem") {
                        if let intVal = Int(value) {
                            controller.addMeasurement(value: intVal)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
