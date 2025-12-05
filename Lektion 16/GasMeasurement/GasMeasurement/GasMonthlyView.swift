//
//  GasMonthlyView.swift
//  GasMeasurement
//
//  Created by dmu mac 29 on 19/11/2025.
//

import SwiftUI

struct GasMonthlyView: View {

    var controller: GasMeasurementController

    var body: some View {
        VStack(alignment: .leading) {
            Text("Månedsoversigt")
                .font(.title2)
                .bold()
                .padding(.horizontal)

            ForEach(controller.groupedByMonth, id: \.0) { month, items in
                Section(header: Text(month).font(.headline)) {
                    ForEach(items) { m in
                        HStack {
                            Text(m.date.formatted(date: .numeric, time: .omitted))
                            Spacer()
                            Text("\(m.measurement) m³")
                        }
                        .padding(.horizontal)
                    }
                }
                Divider().padding(.vertical, 4)
            }
        }
    }
}
