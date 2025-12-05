//
//  ContentView.swift
//  iMap
//
//  Created by dmu mac 29 on 02/10/2025.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @Environment(Controller.self) var controller: Controller
    @State private var markerselection: UUID?
    @State private var previousSelection: UUID?
    @State private var route: MKRoute?
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        ZStack {
            Map(position: $cameraPosition, selection: $markerselection) {
                ForEach(controller.randomUsers) { user in
                    AnnotationView(user: user, controller: controller).tag(user.id)
                }
                
                if let route {
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth: 5)
                }
            }.onChange(of: markerselection) { oldValue, newValue in
                guard let newValue, let oldValue, newValue != oldValue else {return}
                        Task {
                            if let calculatedRoute = await controller.getDirections(from: oldValue, to: newValue) {
                                route = calculatedRoute
                            }
                        }
                    }
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Button("Random user") {
                    withAnimation{
                        if let selectedLoc = controller.randomUsers.randomElement()?.coordinate {
                            cameraPosition = MapCameraPosition.camera(
                                MapCamera(
                                    centerCoordinate: selectedLoc,
                                    distance: 60000,
                                    heading: 180,
                                    pitch: 50
                                )
                            )
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .padding()
            }
            .task {
                await controller.createRandomUsers()
            }
        }
    }
}

#Preview {
    ContentView().environment(Controller())
}
