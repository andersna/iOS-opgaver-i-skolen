//
//  GasMeasurementListView.swift
//  GasMeasurement
//
//  Created by dmu mac 29 on 19/11/2025.
//

import SwiftUI

struct GasMeasurementListView: View {

    @State var controller = GasMeasurementController()
    @State private var showAddSheet = false
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                VStack {
                    List {
                        ForEach(controller.measurements) { m in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Forbrug: \(m.measurement) m³")
                                        .font(.headline)
                                    Text(m.date.formatted())
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                Button(role: .destructive) {
                                    controller.deleteMeasurement(m)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Gasmålinger")
                .toolbar {
                    HStack {
                        Button {
                            controller.addTestData()
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }

                        Button {
                            showAddSheet = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showAddSheet) {
                    AddMeasurementSheet(controller: controller)
                }
            }
            .tabItem {
                Label("Liste", systemImage: "list.bullet")
            }
            .tag(0)
            ScrollView {
                GasChartView(measurements: controller.measurements)
            }
            .tabItem {
                Label("Graf", systemImage: "chart.line.uptrend.xyaxis")
            }
            .tag(1)
            ScrollView {
                GasStatsView(controller: controller)
            }
            .tabItem {
                Label("Statistik", systemImage: "chart.bar")
            }
            .tag(2)
            ScrollView {
                GasMonthlyView(controller: controller)
            }
            .tabItem {
                Label("Måneder", systemImage: "calendar")
            }
            .tag(3)
        }
    }
}

#Preview {
    FirebasePreviewWrapper()
}
