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
    @StateObject private var viewModel = HomeViewModel()

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
            .navigationTitle("Rflect")
            .navigationDestination(isPresented: $viewModel.isShowingDetail) {
                if let journal = viewModel.selectedJournal {
                    JournalDetailView(journal: journal, journalVM: journalVM)
                }
            }
        }
        .onAppear {
            journalVM.loadJournals()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        //        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        //        let container = try! ModelContainer(for: JournalModel.self, configurations: config)
        //        let context = ModelContext(container)

        return HomeView()
    }
}
