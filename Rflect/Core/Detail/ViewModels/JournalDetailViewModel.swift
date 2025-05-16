//
//  JournalDetailViewModel.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 16/05/25.
//

import Foundation
import SwiftUI

@MainActor
class JournalDetailViewModel: ObservableObject {
    // MARK: - Properties
    private let journalViewModel: JournalViewModel
    private let journal: JournalModel

    @Published var title: String
    @Published var notes: String
    @Published var selectedMood: Mood
    @Published var showingAlert = false
    @Published var alertMessage = ""

    // MARK: - Initialization
    init(journal: JournalModel, journalViewModel: JournalViewModel) {
        self.journal = journal
        self.journalViewModel = journalViewModel
        self.title = journal.title
        self.notes = journal.notes
        self.selectedMood = journal.mood
    }

    // MARK: - Actions
    func saveJournal() -> Bool {
        // Validate input
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Title cannot be empty"
            showingAlert = true
            return false
        }

        // Update journal
        journalViewModel.updateJournal(journal, title: title, notes: notes, mood: selectedMood)
        return true
    }

    var date: Date {
        journal.date
    }

    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

// MARK: - Preview Helper
extension JournalDetailViewModel {
    static var preview: JournalDetailViewModel {
        let previewJournal = JournalModel(
            title: "Sample Title",
            notes: "Sample notes for preview",
            mood: .happy
        )
        return JournalDetailViewModel(
            journal: previewJournal,
            journalViewModel: JournalViewModel.preview
        )
    }
}
