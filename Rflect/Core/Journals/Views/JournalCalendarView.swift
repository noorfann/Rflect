//
//  JournalCalendarView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftUI

struct JournalCalendarView: View {
    @EnvironmentObject private var journalVM: JournalViewModel
    @EnvironmentObject private var homeVM: HomeViewModel

    var body: some View {
        ZStack {
            GradientBackground()

            VStack(spacing: 0) {
                calendarView
                journalsHeader

                if journalVM.filteredEntries.isEmpty {
                    journalEmptyList
                        .transition(.opacity)
                        .animation(.easeInOut, value: journalVM.filteredEntries.isEmpty)
                } else {
                    // Using JournalListComponent without delete functionality
                    JournalListComponent(
                        journals: journalVM.filteredEntries,
                        onTapJournal: { journal in
                            homeVM.selectedJournal = journal
                            homeVM.isShowingDetail = true
                        },
                        onDeleteJournal: { _ in
                            // Empty implementation - deletion only handled in JournalListView
                        }
                    )
                    .transition(.opacity)
                    .animation(.easeInOut, value: journalVM.filteredEntries.isEmpty)
                }
            }
        }
        // Delete confirmation removed from JournalCalendarView
    }
}

extension JournalCalendarView {
    private var calendarView: some View {
        DatePicker(
            "Select Date", selection: $journalVM.selectedDate, displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
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

#Preview {
    NavigationStack {
        JournalCalendarView()
            .environmentObject(JournalViewModel.preview)
            .environmentObject(HomeViewModel.preview)
    }
}
