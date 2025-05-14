//
//  EntryCalendarView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftUI

struct EntryCalendarView: View {
    @ObservedObject var viewModel: JournalViewModel
    @Binding var selectedDate: Date
    @Binding var showingEntryForm: Bool

    private var filteredEntries: [JournalEntry] {
        viewModel.entries.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackgroundView(
                    startColor: Color.blue.opacity(0.8),
                    middleColor: Color.blue.opacity(0.6),
                    endColor: Color.blue.opacity(0.2)
                )

                VStack(spacing: 0) {
                    // Calendar view at the top
                    DatePicker(
                        "Select Date", selection: $selectedDate, displayedComponents: [.date]
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

                    // Header for entries list
                    HStack {
                        Text(selectedDate.formatted(date: .long, time: .omitted))
                            .font(.headline)
                            .foregroundColor(.white)

                        Spacer()

                        Text("\(filteredEntries.count) entries")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)

                    // List of entries for selected date
                    if filteredEntries.isEmpty {
                        VStack(spacing: 20) {
                            Spacer()
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 50))
                                .foregroundColor(.white.opacity(0.8))
                            Text("No entries for this date")
                                .font(.headline)
                                .foregroundColor(.white)

                            Button {
                                showingEntryForm = true
                            } label: {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.headline)
                                    Text("Add New Entry")
                                        .fontWeight(.semibold)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.ultraThinMaterial)
                                )
                                .foregroundColor(.white)
                            }

                            Spacer()
                        }
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(filteredEntries, id: \.id) { entry in
                                    EntryRowView(entry: entry)
                                        .padding(.horizontal)
                                        .padding(.top, 8)
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                }
            }
            .navigationTitle("Reflct")

        }
        .onAppear {
            viewModel.loadEntries()
        }
    }
}

#Preview {
    NavigationStack {
        EntryCalendarView(viewModel: JournalViewModel.preview, selectedDate: .constant(.now), showingEntryForm: .constant(false))
    }
}
