//
//  GasStatsView.swift
//  GasMeasurement
//
//  Created by dmu mac 29 on 19/11/2025.
//

import SwiftUI

struct GasStatsView: View {

    var controller: GasMeasurementController

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Statistik")
                .font(.title2)
                .bold()

            HStack {
                statCard(title: "Total", value: "\(controller.total) m³")
                statCard(title: "Snit", value: String(format: "%.1f m³", controller.average))
            }

            HStack {
                statCard(title: "Max", value: "\(controller.maxValue) m³")
                statCard(title: "Min", value: "\(controller.minValue) m³")
            }
        }
        .padding()
    }

    func statCard(title: String, value: String) -> some View {
        VStack {
            Text(title).font(.caption).foregroundColor(.gray)
            Text(value).font(.title3).bold()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
