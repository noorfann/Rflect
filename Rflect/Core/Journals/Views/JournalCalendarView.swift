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

    private var filteredEntries: [JournalModel] {
        journalVM.journals.filter {
            Calendar.current.isDate($0.date, inSameDayAs: homeVM.selectedDate)
        }
    }

    var body: some View {
        ZStack {
            GradientBackground()

            VStack(spacing: 0) {
                calendarView
                journalsHeader

                if filteredEntries.isEmpty {
                    journalEmptyList
                } else {
                    journalList
                }
            }
        }
    }
}

extension JournalCalendarView {
    private var calendarView: some View {
        DatePicker(
            "Select Date", selection: $homeVM.selectedDate, displayedComponents: [.date]
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
            Text(homeVM.selectedDate.formatted(date: .long, time: .omitted))
                .font(.headline)
                .foregroundColor(.white)

            Spacer()

            Text("\(filteredEntries.count) entries")
                .foregroundColor(.white.opacity(0.8))
                .font(.subheadline)
        }
        .padding(.horizontal)
        .padding(.top, 12)
    }

    private var journalList: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(filteredEntries) { journal in
                    JournalRowView(journal: journal)
                        .padding(.horizontal)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            homeVM.selectedJournal = journal
                            homeVM.isShowingDetail = true
                        }
                }
            }
            .padding(.bottom)
        }
        .padding(.top, 12)
        .overlay(alignment: .bottomTrailing) {
            FloatingActionButton(action: {
                homeVM.showingJournalForm = true
            })
            .padding()
        }
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

            FloatingActionButton(action: {
                homeVM.showingJournalForm = true
            })

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
