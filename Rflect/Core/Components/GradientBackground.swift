//
//  GradientBackground.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftUI

struct GradientBackground: View {
    // Customizable gradient colors with default values
    var startColor: Color = Color.blue.opacity(0.6)
    var middleColor: Color = Color.purple.opacity(0.4)
    var endColor: Color = Color.pink.opacity(0.6)
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [startColor, middleColor, endColor]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

// Convenience view modifier for adding the gradient background
struct GradientBackgroundModifier: ViewModifier {
    var startColor: Color = Color.blue.opacity(0.6)
    var middleColor: Color = Color.purple.opacity(0.4)
    var endColor: Color = Color.pink.opacity(0.6)
    
    func body(content: Content) -> some View {
        ZStack {
            GradientBackground(
                startColor: startColor,
                middleColor: middleColor,
                endColor: endColor
            )
            content
        }
    }
}

// Extension to make it easier to apply the gradient background
extension View {
    func withGradientBackground(
        startColor: Color = Color.blue.opacity(0.6),
        middleColor: Color = Color.purple.opacity(0.4),
        endColor: Color = Color.pink.opacity(0.6)
    ) -> some View {
        self.modifier(GradientBackgroundModifier(
            startColor: startColor,
            middleColor: middleColor,
            endColor: endColor
        ))
    }
}

#Preview {
    GradientBackground()
}
