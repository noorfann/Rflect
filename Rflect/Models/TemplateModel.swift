//
//  TemplateModel.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 17/05/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class TemplateModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var notes: String
    var categoryValue: String
    var customTags: [String]
    var isCustom: Bool
    var isAdded: Bool
    var createdAt: Date

    var category: TemplateCategory {
        get { TemplateCategory(rawValue: categoryValue) ?? .custom }
        set { categoryValue = newValue.rawValue }
    }

    init(
        title: String,
        notes: String,
        category: TemplateCategory = .custom,
        customTags: [String] = [],
        isCustom: Bool = false,
        isAdded: Bool = false
    ) {
        self.id = UUID()
        self.title = title
        self.notes = notes
        self.categoryValue = category.rawValue
        self.customTags = customTags
        self.isCustom = isCustom
        self.isAdded = isAdded
        self.createdAt = Date()
    }
}

// MARK: - Computed Properties
extension TemplateModel {
    var formattedNotes: AttributedString {
        (try? AttributedString(markdown: notes)) ?? AttributedString(notes)
    }

    var preview: String {
        let maxLength = 100
        if notes.count <= maxLength {
            return notes
        }
        return notes.prefix(maxLength) + "..."
    }

    var wordCount: Int {
        notes.split(separator: " ").count
    }
}

// MARK: - Validation
extension TemplateModel {
    static let maxTitleLength = 100
    static let maxNotesLength = 5000
    static let maxCustomTags = 5

    func validate() -> Bool {
        guard !title.isEmpty,
            title.count <= Self.maxTitleLength,
            !notes.isEmpty,
            notes.count <= Self.maxNotesLength,
            customTags.count <= Self.maxCustomTags
        else {
            return false
        }
        return true
    }
}

// MARK: - Preview Helpers
extension TemplateModel {
    static var previewTemplate: TemplateModel {
        TemplateModel(
            title: "Morning Reflection",
            notes: """
                # Morning Reflection

                - How did I sleep?
                - What am I grateful for this morning?
                - What's my main focus for today?
                - How am I feeling right now?
                """,
            category: .morning
        )
    }

    static var defaultTemplates: [TemplateModel] {
        [
            TemplateModel(
                title: "Morning Reflection",
                notes: """
                    # Morning Reflection

                    - How did I sleep?
                    - What am I grateful for this morning?
                    - What's my main focus for today?
                    - How am I feeling right now?
                    """,
                category: .morning
            ),
            TemplateModel(
                title: "Evening Reflection",
                notes: """
                    # Evening Reflection

                    - What went well today?
                    - What could have gone better?
                    - What am I grateful for?
                    - How am I feeling now?
                    """,
                category: .evening
            ),
            TemplateModel(
                title: "Gratitude Journal",
                notes: """
                    # Daily Gratitude

                    Three things I'm grateful for today:
                    1.
                    2.
                    3.

                    Why am I grateful for these things?
                    """,
                category: .gratitude
            ),
            TemplateModel(
                title: "Goal Setting",
                notes: """
                    # Goals & Planning

                    Today's top 3 priorities:
                    1.
                    2.
                    3.

                    Steps to achieve these goals:

                    Potential obstacles and solutions:
                    """,
                category: .goals
            ),
        ]
    }
}
