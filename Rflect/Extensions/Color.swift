//
//  Color.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftUI
import UIKit

extension Color {
    static let theme = ColorTheme()

    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 8 {
            r = CGFloat((rgb & 0xFF00_0000) >> 24) / 255
            g = CGFloat((rgb & 0x00FF_0000) >> 16) / 255
            b = CGFloat((rgb & 0x0000_FF00) >> 8) / 255
            a = CGFloat(rgb & 0x0000_00FF) / 255
        } else if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255
            b = CGFloat(rgb & 0x0000FF) / 255
        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }

    func toHex() -> String? {
        let uiColor = UIColor(self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        guard uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) else { return nil }

        let rgb = String(
            format: "#%02X%02X%02X%02X",
            Int(r * 255),
            Int(g * 255),
            Int(b * 255),
            Int(a * 255)
        )

        return rgb
    }
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondaryText = Color("SecondaryTextColor")
}
