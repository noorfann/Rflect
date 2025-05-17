//
//  RflectApp.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftData
import SwiftUI

@main
struct RflectApp: App {
    // SwiftData container for the app
    let container: ModelContainer

    // Initialize the viewModels with the container's context
    @StateObject private var journalVM: JournalViewModel
    @StateObject private var homeVM = HomeViewModel()
    @StateObject private var settingsVM = SettingsViewModel()

    init() {
        do {
            // Create a persistent container for JournalEntry
            container = try ModelContainer(for: JournalModel.self)

            // Initialize the viewModel with the container's context
            let context = container.mainContext
            _journalVM = StateObject(wrappedValue: JournalViewModel(context: context))
        } catch {
            // Handle container creation failure
            fatalError("Failed to create model container: \(error.localizedDescription)")
        }
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(journalVM)
                .environmentObject(homeVM)
                .environmentObject(settingsVM)
        }
    }
}
