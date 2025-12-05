//
//  BellView.swift
//  YATDA
//
//  Created by dmu mac 29 on 27/11/2025.
//
import SwiftUI

struct BellView: View{
    @Binding var isNotified: Bool
    
    var body: some View {
        HStack(spacing: 20){
            
            Image(systemName: "bell")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(.pink)
                .phaseAnimator(NotifyAnimationPhase.allCases, trigger: isNotified){ content, phase in
                    content
                        .scaleEffect(phase.scale)
                        .rotationEffect(.degrees(phase.rotationDegrees))
                        .offset(y: phase.yOffset)
                }.padding()
        }
    }
}

#Preview {
    BellView(isNotified: .constant(true))
}

enum NotifyAnimationPhase: CaseIterable {
    case initial, lift, shakeLeft, shakeRight
    
    var yOffset: CGFloat {
        switch self {
        case .initial: 0
        case .lift: -30
        case .shakeLeft: -30
        case .shakeRight: -30
        }
    }
    
    var scale: CGFloat {
        switch self {
        case .initial: 1
        case .lift: 1.2
        case .shakeLeft: 1.2
        case .shakeRight: 1.2
        }
    }
    
    var rotationDegrees: Double {
        switch self {
        case .initial: 0
        case .lift: 0
        case .shakeLeft: -30
        case .shakeRight: 30
        }
    }
}
