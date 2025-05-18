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
    @EnvironmentObject var templateVM: TemplateViewModel
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var selectedMood: Mood = .neutral
    @State private var entryDate: Date = Date()
    @State private var showTemplates = false

    // Optional parameter to pre-set the entry date (useful when coming from calendar view)
    var initialDate: Date? = nil

    init(initialDate: Date? = nil) {
        self.initialDate = initialDate
    }

    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground()
                ScrollView {  // Wrap content in ScrollView
                    VStack(spacing: 0) {
                            datePicker
                            moodSelection
                            templateList
                            journalForm
                    }
                    .padding(.bottom, 300)
                    .navigationTitle("How's today?")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            XMarkButton {
                                dismiss()
                            }
                        }
                    }
                }
                // Add this to handle keyboard adjustments
                .ignoresSafeArea(.keyboard)
            }
        }
        .onAppear {
            if let initialDate = initialDate {
                entryDate = initialDate
            }
        }
    }

    private func applyTemplate(_ template: TemplateModel) {
        if settingsVM.showJournalTitle {
            title = template.title
        }
        notes = template.notes
    }
}

#Preview {
    JournalFormView(initialDate: nil)
        .environmentObject(JournalViewModel.preview)
        .environmentObject(HomeViewModel())
        .environmentObject(SettingsViewModel())
        .environmentObject(TemplateViewModel.preview)
}

// MARK: - Subviews
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
                        .background(
                            selectedMood == mood
                                ? Color.accentColor.opacity(0.3)
                                : .clear
                        )
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
                    .autocorrectionDisabled(true)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
            }

            TextEditorWithPlaceholder(
                text: $notes,
                placeholder: "Describe your day.."
            )
            .padding(.horizontal)
            .padding(.bottom, 40)  // Add padding at the bottom to prevent text from being covered by keyboard
            .background(Color.white.opacity(0.1))
            .scrollContentBackground(.hidden)
            .cornerRadius(
                10,
                corners: settingsVM.showJournalTitle
                    ? [.bottomLeft, .bottomRight]
                    : .allCorners
            )
            .foregroundStyle(Color.theme.secondaryText)
        }
        .padding(.horizontal)
        .padding(.top, 10)
        .padding(.bottom, 60)  // Add extra padding to push content up
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                floatingButton
            }
        }
    }

    // Dummy template list for testing
    private var dummyTemplateList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(1...5, id: \.self) { index in
                    Button(action: {
                        notes = "Template \(index) content applied"
                    }) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Template \(index)")
                                .font(.headline)
                            Text("This is template \(index) preview text")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                        .padding()
                        .frame(width: 200)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(12)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.2))
        .frame(height: 100)
    }

    private var floatingButton: some View {
        HStack {
            Spacer()
            FloatingActionButton(
                action: {
                    journalVM.addJournal(
                        title: title,
                        notes: notes,
                        mood: selectedMood,
                        date: entryDate
                    )
                    dismiss()
                },
                icon: "checkmark"
            )
            .disabled(
                (settingsVM.showJournalTitle && title.trimmingCharacters(in: .whitespaces).isEmpty)
                    || notes.trimmingCharacters(in: .whitespaces).isEmpty  // Also check if notes is empty
            )
            .contentShape(Rectangle())  // Add this to improve tappable area
        }
        .padding(.trailing, 20)
        .padding(.bottom, 20)
        .padding()
        .frame(maxWidth: .infinity)
    }

    private var templateList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(templateVM.userTemplates, id: \.id) { template in
                    TemplatePreviewCard(template: template) {
                        applyTemplate(template)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
        .background(Color.theme.background.opacity(0.05))
    }
}

struct TemplatePreviewCard: View {
    let template: TemplateModel
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: template.category.systemImageName)
                    Text(template.title)
                        .font(.headline)
                }
                Text(template.preview)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }
}
