//
//  JournalViewModel.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import Foundation
import SwiftData
import SwiftUI

// MARK: - Model References
private var journalModelReference = JournalModel.self

@MainActor
class JournalViewModel: ObservableObject {
    @Published var journals: [JournalModel] = []
    @Published var selectedDate: Date = Date()

    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
        loadJournals()
    }

    func loadJournals() {
        let descriptor = FetchDescriptor<JournalModel>(sortBy: [
            SortDescriptor(\.date, order: .reverse)
        ])
        do {
            journals = try context.fetch(descriptor)
        } catch {
            print("Error loading entries: \(error)")
        }
    }

    func addJournal(title: String, notes: String, mood: Mood, date: Date = Date()) {
        let newEntry = JournalModel(title: title, notes: notes, mood: mood)
        newEntry.date = date
        context.insert(newEntry)

        save()
    }

    func deleteJournal(_ entry: JournalModel) {
        context.delete(entry)
        save()
    }

    func save() {
        do {
            try context.save()
            loadJournals()
        } catch {
            print("Failed to save/delete entry: \(error)")
        }
    }

    func updateJournal(_ journal: JournalModel, title: String, notes: String, mood: Mood) {
        journal.title = title
        journal.notes = notes
        journal.mood = mood
        save()
    }
    
    var filteredEntries: [JournalModel] {
        journals.filter {
            Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
        }
    }
}

// Safe preview extension for JournalViewModel
extension JournalViewModel {
    static var preview: JournalViewModel {
        do {
            let container = try ModelContainer(
                for: JournalModel.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true))
            let context = ModelContext(container)
            return JournalViewModel(context: context)
        } catch {
            // Use an in-memory context as fallback
            print("Error creating preview model container: \(error)")
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try! ModelContainer(for: JournalModel.self, configurations: config)
            return JournalViewModel(context: ModelContext(container))
        }
    }
}
