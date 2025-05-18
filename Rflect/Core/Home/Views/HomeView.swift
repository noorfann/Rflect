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
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                TabView(selection: $viewModel.selectedTab) {
                    // List View
                    JournalListView()
                        .tag(Tab.list)
                        .tabItem {
                            Label("List", systemImage: "book.fill")
                        }
                        .toolbar(.hidden, for: .tabBar)
                    
                    // Calendar View
                    JournalCalendarView()
                        .tag(Tab.calendar)
                        .tabItem {
                            Label("Calendar", systemImage: "calendar")
                        }
                        .toolbar(.hidden, for: .tabBar)
                }
                
                // Custom TabBar
                CustomTabBarView(selectedTab: $viewModel.selectedTab, showingJournalForm: $viewModel.showingJournalForm)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
            }
            .accentColor(.blue)
            .sheet(isPresented: $viewModel.showingJournalForm) {
                JournalFormView(initialDate: journalVM.selectedDate)
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
