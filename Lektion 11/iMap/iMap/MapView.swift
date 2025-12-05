//
//  MapView.swift
//  iMap
//
//  Created by dmu mac 29 on 02/10/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var mapCameraPosition: MapCameraPosition = .camera(MapCamera(
        centerCoordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
    distance: 600,
    heading: 100,
    pitch:50
    ))
    var body: some View {
        Map(position: $mapCameraPosition){
            Marker("Et eller andet sted", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))
            Annotation("Det samme sted", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4196), content: {
                Circle()
                    .fill(Color.red.opacity(0.3))
                    .frame(width: 100, height: 100)
            })
        }
    }
}

#Preview {
    MapView()
}
