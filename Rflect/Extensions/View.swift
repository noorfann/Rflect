//
//  View.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 16/05/25.
//

import Foundation
import SwiftUI


// Extension to make the shape modifier easier to use
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
