//
//  JournalFormView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftData
import SwiftUI

struct JournalFormView: View {
    @EnvironmentObject var journalVM: JournalViewModel
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var selectedMood: Mood = .neutral
    @State private var entryDate: Date = Date()

    // Optional parameter to pre-set the entry date (useful when coming from calendar view)
    var initialDate: Date? = nil

    init(initialDate: Date?) {
        self.initialDate = initialDate
    }

    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground()
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        datePicker

                        // select mood of todays
                        moodSelection

                        // insert journal with title and titleDesc
                        journalForm

                    }
                }

                // Floating Action Button
                VStack {
                    Spacer()
                    FloatingActionButton(
                        action: {
                            journalVM.addJournal(
                                title: title, notes: notes, mood: selectedMood, date: entryDate)
                            dismiss()
                        }, icon: "checkmark"
                    )
                    .disabled(
                        settingsVM.showJournalTitle
                            ? title.trimmingCharacters(in: .whitespaces).isEmpty : false
                    )
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
                .padding()
                .frame(maxWidth: .infinity)
                .navigationTitle("How's today?")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        XMarkButton {
                            dismiss()
                        }
                    }
                }
            }
        }
        .onAppear {
            if let initialDate = initialDate {
                entryDate = initialDate
            }
        }
    }
}

#Preview {
    JournalFormView(initialDate: nil)
        .environmentObject(JournalViewModel.preview)
        .environmentObject(HomeViewModel())
}

extension JournalFormView {

    private var datePicker: some View {
        DatePicker("Date", selection: $entryDate, displayedComponents: [.date])
            .padding(.horizontal)
            .padding(.top, 10)
    }

    private var moodSelection: some View {
        HStack {
            ForEach(Mood.allCases, id: \.self) { mood in
                Button {
                    selectedMood = mood
                } label: {
                    Text(mood.emoji)
                        .font(.largeTitle)
                        .padding()
                        .background(selectedMood == mood ? Color.accentColor.opacity(0.3) : .clear)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.top, 20)
    }

    private var journalForm: some View {
        VStack(spacing: 0) {
            if settingsVM.showJournalTitle {
                TextField("Title", text: $title)
                    .font(.title)
                    .bold()
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10, corners: [.topLeft, .topRight])
            }

            TextEditorWithPlaceholder(text: $notes, placeholder: "Describe your day..")
                .padding(.horizontal)
                .background(Color.white.opacity(0.1))
                .scrollContentBackground(.hidden)
                .cornerRadius(
                    10,
                    corners: settingsVM.showJournalTitle
                        ? [.bottomLeft, .bottomRight] : .allCorners
                )
                .foregroundStyle(Color.theme.secondaryText)
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }

    private var submitButton: some View {
        FloatingActionButton(
            action: {
                journalVM.addJournal(
                    title: title, notes: notes, mood: selectedMood, date: entryDate)
                dismiss()
            }, icon: "checkmark"
        )
        .disabled(
            settingsVM.showJournalTitle
                ? title.trimmingCharacters(in: .whitespaces).isEmpty : false
        )
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
