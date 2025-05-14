//
//  RflectApp.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftUI
import SwiftData

// No top-level code before @main attribute
@main
struct RflectApp: App {
    // SwiftData container for the app
    let container: ModelContainer
    
    // Initialize the viewModel with the container's context
    @StateObject private var viewModel: JournalViewModel
    
    init() {
        do {
            // Create a persistent container for JournalEntry
            container = try ModelContainer(for: JournalEntry.self)
            
            // Initialize the viewModel with the container's context
            let context = container.mainContext
            _viewModel = StateObject(wrappedValue: JournalViewModel(context: context))
        } catch {
            // Handle container creation failure
            fatalError("Failed to create model container: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
                .environmentObject(viewModel)
        }
    }
}
