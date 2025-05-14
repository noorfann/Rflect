//
//  EntryHomeView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftData
import SwiftUI

struct EntryHomeView: View {
    @StateObject private var viewModel: JournalViewModel
    @State private var showingEntryForm = false
    @State private var selectedDate: Date = Date()

    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: JournalViewModel(context: modelContext))
    }

    var body: some View {
        NavigationStack {
            TabView {
                EntryListView(showingEntryForm: $showingEntryForm)
                    .tabItem {
                        Label("List", systemImage: "book.fill")
                    }

                EntryCalendarView(
                    viewModel: viewModel, selectedDate: $selectedDate,
                    showingEntryForm: $showingEntryForm
                )
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            }
            .accentColor(.blue)
            .environmentObject(viewModel)
            .sheet(isPresented: $showingEntryForm) {
                EntryFormView(initialDate: selectedDate)
                    .presentationBackground(.clear)
                    .presentationCornerRadius(16)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingEntryForm = true
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .foregroundStyle(Color.white)
                    }
                }
            }
            .navigationTitle("Rflect")
        }
    }
}

struct EntryHomeView_Previews: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: JournalEntry.self, configurations: config)
        let context = ModelContext(container)

        return EntryHomeView(modelContext: context)
    }
}
