//
//  EntryHomeView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var journalVM: JournalViewModel
    @EnvironmentObject private var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            TabView {
                // List View
                JournalListView()
                    .environmentObject(viewModel)
                    .tabItem {
                        Label("List", systemImage: "book.fill")
                    }

                // Calendar View
                JournalCalendarView()
                    .environmentObject(viewModel)
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
            }
            .accentColor(.blue)
            .sheet(isPresented: $viewModel.showingJournalForm) {
                JournalFormView(initialDate: viewModel.selectedDate)
                    .presentationCornerRadius(16)
            }
            .sheet(isPresented: $viewModel.showingSettings) {
                SettingsView()
                    .presentationDragIndicator(.visible)
            }
            .navigationTitle("Rflect")
            .navigationDestination(isPresented: $viewModel.isShowingDetail) {
                if let journal = viewModel.selectedJournal {
                    JournalDetailView(journal: journal, journalVM: journalVM)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showingSettings = true
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
        }
        .onAppear {
            journalVM.loadJournals()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(JournalViewModel.preview)
        .environmentObject(HomeViewModel())
        .environmentObject(SettingsViewModel())
}
