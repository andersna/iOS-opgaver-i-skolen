//
//  ContentView.swift
//  MapDirections
//
//  Created by dmu mac 29 on 21/10/2025.
//

import SwiftUI
import MapKit


struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let tag: String
}



let locations: [Location] = [Location(name: "København", coordinate: CLLocationCoordinate2D(latitude: 55.6761, longitude: 12.5683), tag: "A"), Location(name: "Odense", coordinate: CLLocationCoordinate2D(latitude: 55.4038, longitude: 10.4024), tag: "B")]

struct ContentView: View {
    @State private var markerselection: String? = nil
    @State private var route: MKRoute?
    
    var body: some View {
        Map(selection: $markerselection){
            ForEach(locations) { location in
                Marker(location.name, systemImage: "pen.circle", coordinate: location.coordinate).tag(location.tag)
            }
            
            if let route{
                MapPolyline(route.polyline)
                    .stroke(.blue, lineWidth: 5)
            }
        }.onChange(of: markerselection){ oldValue, newValue in
            guard let oldTag = oldValue,
                  let newTag = newValue,
                  let source = locations.first(where: { $0.tag == oldTag }),
                  let destination = locations.first(where: { $0.tag == newTag }) else {
                return
            }
            let sourceMK = MKMapItem(location: CLLocation(latitude: source.coordinate.latitude, longitude: source.coordinate.longitude), address: nil)
            let destinationMK = MKMapItem(location: CLLocation(latitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude), address: nil)
            getDirections(from: sourceMK, to: destinationMK)
        }.ignoresSafeArea()
    }
}

extension ContentView {
    func getDirections(from: MKMapItem, to: MKMapItem){
        route = nil
         let request = MKDirections.Request()
         request.transportType = .walking
         request.source = from
         request.destination = to
         Task {
             let directions = MKDirections(request: request)
             let response = try? await directions.calculate()
             withAnimation {
                 route = response?.routes.first
             }
         }
     }
}


#Preview {
    ContentView()
}
