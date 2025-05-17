//
//  SettingsViewModel.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 17/05/25.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    // Title visibility setting
    @AppStorage("showJournalTitle") var showJournalTitle = true

    // Gradient color components
    @AppStorage("gradientStartRed") var startRed: Double = 0.0
    @AppStorage("gradientStartGreen") var startGreen: Double = 0.6
    @AppStorage("gradientStartBlue") var startBlue: Double = 1.0
    @AppStorage("gradientStartAlpha") var startAlpha: Double = 0.6

    @AppStorage("gradientMiddleRed") var middleRed: Double = 0.5
    @AppStorage("gradientMiddleGreen") var middleGreen: Double = 0.0
    @AppStorage("gradientMiddleBlue") var middleBlue: Double = 0.5
    @AppStorage("gradientMiddleAlpha") var middleAlpha: Double = 0.4

    @AppStorage("gradientEndRed") var endRed: Double = 1.0
    @AppStorage("gradientEndGreen") var endGreen: Double = 0.75
    @AppStorage("gradientEndBlue") var endBlue: Double = 0.8
    @AppStorage("gradientEndAlpha") var endAlpha: Double = 0.6

    
    // Published computed properties for SwiftUI Color
    @Published var gradientStartColor: Color = Color.theme.background.opacity(0.1) {
        didSet {
            if let components = gradientStartColor.cgColor?.components {
                startRed = Double(components[0])
                startGreen = Double(components[1])
                startBlue = Double(components[2])
                startAlpha = Double(components[3])
                objectWillChange.send()
            }
        }
    }

    @Published var gradientMiddleColor: Color = Color.theme.background.opacity(0.6) {
        didSet {
            if let components = gradientMiddleColor.cgColor?.components {
                middleRed = Double(components[0])
                middleGreen = Double(components[1])
                middleBlue = Double(components[2])
                middleAlpha = Double(components[3])
                objectWillChange.send()
            }
        }
    }

    @Published var gradientEndColor: Color = Color.theme.accent.opacity(0.8) {
        didSet {
            if let components = gradientEndColor.cgColor?.components {
                endRed = Double(components[0])
                endGreen = Double(components[1])
                endBlue = Double(components[2])
                endAlpha = Double(components[3])
                objectWillChange.send()
            }
        }
    }

    init() {
        loadColors()
    }

    private func loadColors() {
        gradientStartColor = Color(
            .sRGB,
            red: startRed,
            green: startGreen,
            blue: startBlue,
            opacity: startAlpha)

        gradientMiddleColor = Color(
            .sRGB,
            red: middleRed,
            green: middleGreen,
            blue: middleBlue,
            opacity: middleAlpha)

        gradientEndColor = Color(
            .sRGB,
            red: endRed,
            green: endGreen,
            blue: endBlue,
            opacity: endAlpha)
    }

    // Reset colors to default
    func resetColors() {
        gradientStartColor = Color.theme.background.opacity(0.1)
        gradientMiddleColor = Color.theme.background.opacity(0.6)
        gradientEndColor = Color.theme.accent.opacity(0.8)
    }
}
