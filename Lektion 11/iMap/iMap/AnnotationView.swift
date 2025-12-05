//
//  AnnotationView.swift
//  iMap
//
//  Created by dmu mac 29 on 23/10/2025.
//

import SwiftUI
import MapKit

struct AnnotationView: MapContent {
    let user: RandomUser
    let controller: Controller
    
    @MapContentBuilder
    var body: some MapContent {
        if let coord = user.coordinate {
            Marker("\(user.name.first) \(user.name.last)", coordinate: coord)
        }
    }
}
