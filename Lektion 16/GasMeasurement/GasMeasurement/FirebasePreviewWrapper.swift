//
//  FirebasePreviewWrapper.swift
//  GasMeasurement
//
//  Created by dmu mac 29 on 19/11/2025.
//

import FirebaseCore
import SwiftUI

func configureFirebaseForPreview() {
    if FirebaseApp.app() == nil {
        FirebaseApp.configure()
    }
}

struct FirebasePreviewWrapper: View {
    init() {
        configureFirebaseForPreview()
    }

    var body: some View {
        GasMeasurementListView()
    }
}
