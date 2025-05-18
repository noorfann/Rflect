//
//  GradientBackground.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftUI

struct GradientBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.theme.background.opacity(0.1),
                Color.theme.background.opacity(0.6),
                Color.theme.background.opacity(0.8),
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    GradientBackground()
        .environmentObject(SettingsViewModel())
}
