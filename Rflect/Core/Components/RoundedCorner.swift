//
//  RoundedRectangle.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 16/05/25.
//

import SwiftUI

// Custom RoundedCorner shape for applying different corner radiuses
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    RoundedCorner()
}
