//
//  Boarder.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 4/8/25.
//

import SwiftUI

struct DebugConfig {
    // Set to false to disable all debug borders.
    static let showBorders: Bool = true
    static let borderWidth: CGFloat = 2
    
    // Array of colors you can use for debugging.
    static let debugColors: [Color] = [
        .red, .green, .blue, .purple, .orange, .yellow
    ]
    
    // Helper function to get a color based on an index.
    static func color(at index: Int) -> Color {
        return debugColors[index % debugColors.count]
    }
}

extension View {
    @ViewBuilder
    func debugBorder(_ color: Color, width: CGFloat = DebugConfig.borderWidth, show: Bool = DebugConfig.showBorders) -> some View {
        if show {
            self.border(color, width: width)
        } else {
            self
        }
    }
}
