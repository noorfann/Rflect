//
//  TemplateCategory.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 17/05/25.
//

import Foundation

enum TemplateCategory: String, Codable, Hashable, CaseIterable {
    case morning = "Morning Reflection"
    case evening = "Evening Reflection"
    case gratitude = "Gratitude"
    case goals = "Goals & Planning"
    case custom = "Custom"

    var description: String {
        return self.rawValue
    }

    var systemImageName: String {
        switch self {
        case .morning:
            return "sunrise"
        case .evening:
            return "moon.stars"
        case .gratitude:
            return "heart"
        case .goals:
            return "target"
        case .custom:
            return "pencil"
        }
    }
}
