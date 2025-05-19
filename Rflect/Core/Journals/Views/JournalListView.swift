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
                    journalsHeader

                    if journalVM.filteredEntries.isEmpty {
                        journalEmptyList
                            .transition(.opacity)
                            .animation(.easeInOut, value: journalVM.filteredEntries.isEmpty)
                    } else {
                        JournalListComponent(
                            journals: journalVM.filteredEntries,
                            onTapJournal: { journal in
                                homeVM.selectedJournal = journal
                                homeVM.isShowingDetail = true
                            },
                            onDeleteJournal: { journal in
                                homeVM.journalToDelete = journal
                                homeVM.showDeleteConfirmation = true
                            }
                        )
                        .transition(.opacity)
                        .animation(.easeInOut, value: journalVM.filteredEntries.isEmpty)
                    }
                }
            }
        }
        .deleteConfirmation(
            isPresented: $homeVM.showDeleteConfirmation,
            itemToDelete: $homeVM.journalToDelete
        ) { journal in
            journalVM.deleteJournal(journal)
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

    private var journalsHeader: some View {
        HStack {
            Text(journalVM.selectedDate.formatted(date: .long, time: .omitted))
                .font(.headline)

            Spacer()

            Text("\(journalVM.filteredEntries.count) entries")
                .foregroundStyle(Color.theme.secondaryText)
                .font(.subheadline)
        }
        .padding(.horizontal)
        .padding(.top, 12)
    }

    private var journalEmptyList: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "square.and.pencil")
                .font(.system(size: 50))
                .foregroundColor(.white.opacity(0.8))
            Text("No entries for this date")
                .font(.headline)
                .foregroundColor(.white)

            Spacer()
        }
    }
}
