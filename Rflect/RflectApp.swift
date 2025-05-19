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
    @StateObject private var templateVM: TemplateViewModel
    @StateObject private var homeVM = HomeViewModel()
    @StateObject private var settingsVM = SettingsViewModel()
    
    @State private var showLaunchView: Bool = true

    init() {
        do {
            // Create a persistent container
            container = try ModelContainer(for: JournalModel.self, TemplateModel.self)

            // Initialize the viewModel with the container's context
            let context = container.mainContext
            _journalVM = StateObject(wrappedValue: JournalViewModel(context: context))
            _templateVM = StateObject(wrappedValue: TemplateViewModel(context: context))
        } catch {
            // Handle container creation failure
            fatalError("Failed to create model container: \(error.localizedDescription)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeView()
                    .environmentObject(journalVM)
                    .environmentObject(homeVM)
                    .environmentObject(settingsVM)
                    .environmentObject(templateVM)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.push(from: .trailing))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
