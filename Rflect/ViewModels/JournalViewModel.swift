//
//  JournalViewModel.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
class JournalViewModel: ObservableObject {
    @Published var entries: [JournalEntry] = []

    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
        loadEntries()
    }
    
    // Add method to update the context after initialization
    func updateModelContext(_ newContext: ModelContext) {
        self.context = newContext
        loadEntries()
    }

    func loadEntries() {
        let descriptor = FetchDescriptor<JournalEntry>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        do {
            entries = try context.fetch(descriptor)
        } catch {
            print("Error loading entries: \(error)")
        }
    }

    func addEntry(title: String, notes: String, mood: Mood, date: Date = Date()) {
        let newEntry = JournalEntry(title: title, notes: notes, mood: mood)
        newEntry.date = date // Allow setting a specific date
        context.insert(newEntry)

        do {
            try context.save()
            loadEntries()
        } catch {
            print("Failed to save new entry: \(error)")
        }
    }

    func deleteEntry(_ entry: JournalEntry) {
        context.delete(entry)
        do {
            try context.save()
            loadEntries()
        } catch {
            print("Failed to delete entry: \(error)")
        }
    }
}

// Safe preview extension for JournalViewModel
extension JournalViewModel {
    static var preview: JournalViewModel {
        do {
            let container = try ModelContainer(for: JournalEntry.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
            let context = ModelContext(container)
            return JournalViewModel(context: context)
        } catch {
            // Use an in-memory context as fallback
            print("Error creating preview model container: \(error)")
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try! ModelContainer(for: JournalEntry.self, configurations: config)
            return JournalViewModel(context: ModelContext(container))
        }
    }
}

