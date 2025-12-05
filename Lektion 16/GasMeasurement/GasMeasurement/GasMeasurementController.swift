//
//  GasMeasurementController.swift
//  GasMeasurement
//
//  Created by dmu mac 29 on 19/11/2025.
//

import Foundation

@Observable
class GasMeasurementController {

    var measurements: [GasMeasurement] = []
    private let service = FirebaseService()

    init() {
        service.listenToMeasurements { [weak self] newList in
            self?.measurements = newList
        }
    }

    func addMeasurement(value: Int) {
        let measurement = GasMeasurement(
            id: nil,
            date: Date(),
            measurement: value
        )
        service.addMeasurement(measurement)
    }

    func deleteMeasurement(_ m: GasMeasurement) {
        if let id = m.id {
            service.deleteMeasurement(id: id)
        }
    }
    func addTestData() {
        let testValues = [12, 15, 19, 11, 14, 18, 21, 20]

        for v in testValues {
            let m = GasMeasurement(id: nil, date: Date(), measurement: v)
            service.addMeasurement(m)
        }
    }
}

extension GasMeasurementController {

    var total: Int {
        measurements.reduce(0) { $0 + $1.measurement }
    }

    var average: Double {
        measurements.isEmpty ? 0 : Double(total) / Double(measurements.count)
    }

    var maxValue: Int {
        measurements.map { $0.measurement }.max() ?? 0
    }

    var minValue: Int {
        measurements.map { $0.measurement }.min() ?? 0
    }
    
    var groupedByMonth: [(String, [GasMeasurement])] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"

        let groups = Dictionary(grouping: measurements) { m in
            formatter.string(from: m.date)
        }

        return groups.sorted { $0.key < $1.key }
    }
}
