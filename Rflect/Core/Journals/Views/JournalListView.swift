//
//  JournalListView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftData
import SwiftUI

struct JournalListView: View {
    @EnvironmentObject private var journalVM: JournalViewModel
    @EnvironmentObject private var homeVM: HomeViewModel

    var body: some View {
        ZStack(alignment: .center) {
            GradientBackground()
            if journalVM.journals.isEmpty {
                JournalEmptyView(onTapAction: {
                    homeVM.showingJournalForm = true
                })
            } else {
                VStack(spacing: 10) {
                    calendarView
                    List(journalVM.journals) { journal in
                        JournalRow(journal: journal)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                homeVM.selectedJournal = journal
                                homeVM.isShowingDetail = true
                            }
                    }
                    .listStyle(.plain)
                    .listRowSpacing(0)
                    .safeAreaInset(edge: .bottom) {
                        Color.clear.frame(height: 100)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        JournalListView()
            .environmentObject(JournalViewModel.preview)
            .environmentObject(HomeViewModel.preview)
    }
}

extension JournalListView {
    private var calendarView: some View {
        DatePicker(
            "Select Date", selection: $journalVM.selectedDate, displayedComponents: [.date]
        )
        .datePickerStyle(.compact)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .shadow(radius: 5)
        )
        .padding(.horizontal)
        .padding(.top)
    }
}
