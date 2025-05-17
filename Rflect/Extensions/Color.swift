//
//  Color.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 16/05/25.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
//    static let launch = LaunchTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondaryText = Color("SecondaryTextColor")
}

//struct LaunchTheme {
//    let background = Color("LaunchBackgroundColor")
//    let accent = Color("LaunchAccentColor")
//}
