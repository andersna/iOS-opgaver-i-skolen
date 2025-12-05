//
//  GasChartView.swift
//  GasMeasurement
//
//  Created by dmu mac 29 on 19/11/2025.
//

import SwiftUI
import Charts

struct GasChartView: View {

    var measurements: [GasMeasurement]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Forbrugsgraf")
                .font(.title2)
                .bold()

            Chart {
                ForEach(measurements.sorted(by: { $0.date < $1.date })) { m in
                    LineMark(
                        x: .value("Dato", m.date),
                        y: .value("Gasforbrug", m.measurement)
                    )
                }
            }
            .frame(height: 250)
            .padding(.vertical)
        }
        .padding(.horizontal)
    }
}
