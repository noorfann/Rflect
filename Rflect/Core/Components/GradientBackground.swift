//
//  GradientBackground.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftUI

struct GradientBackground: View {
    @EnvironmentObject private var settings: SettingsViewModel

    // Optional custom colors
    var startColor: Color?
    var middleColor: Color?
    var endColor: Color?

    private var effectiveStartColor: Color {
        startColor ?? settings.gradientStartColor
    }

    private var effectiveMiddleColor: Color {
        middleColor ?? settings.gradientMiddleColor
    }

    private var effectiveEndColor: Color {
        endColor ?? settings.gradientEndColor
    }

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                effectiveStartColor,
                effectiveMiddleColor,
                effectiveEndColor,
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

// Convenience view modifier for adding the gradient background
struct GradientBackgroundModifier: ViewModifier {
    var startColor: Color?
    var middleColor: Color?
    var endColor: Color?

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
        startColor: Color? = nil,
        middleColor: Color? = nil,
        endColor: Color? = nil
    ) -> some View {
        self.modifier(
            GradientBackgroundModifier(
                startColor: startColor,
                middleColor: middleColor,
                endColor: endColor
            ))
    }
}

#Preview {
    GradientBackground()
        .environmentObject(SettingsViewModel())
}
