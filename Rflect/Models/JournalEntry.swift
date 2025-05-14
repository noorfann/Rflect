//
//  JournalEntry.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import Foundation
import SwiftData

enum Mood: Int, Codable, CaseIterable {
    case verySad = 1, sad, neutral, happy, veryHappy
    
    var emoji: String {
        switch self {
        case .verySad: return "😞"
        case .sad: return "😐"
        case .neutral: return "🙂"
        case .happy: return "😃"
        case .veryHappy: return "🤩"
        }
    }
}

@Model
class JournalEntry {
    @Attribute(.unique) var id: UUID
    var date: Date
    var title: String
    var notes: String
    var moodValue: Int
    
    // info
    /**
     Computed property to work with the enum
     when `set` we set the moodValue using the rawValue: Int
     when `get` we create the enum using the moodValue
     **/
    var mood: Mood {
        get { Mood(rawValue: moodValue) ?? .neutral }
        set { moodValue = newValue.rawValue }
    }

    init(title: String, notes: String, mood: Mood) {
        self.id = UUID()
        self.date = Date()
        self.title = title
        self.notes = notes
        self.moodValue = mood.rawValue
    }
}
