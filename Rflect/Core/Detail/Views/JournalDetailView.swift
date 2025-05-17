//
//  JournalDetailView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 16/05/25.
//

import SwiftData
import SwiftUI

struct JournalDetailView: View {
    // MARK: - Environment
    @StateObject private var detailVM: JournalDetailViewModel
    @Environment(\.dismiss) private var dismiss

    // MARK: - Initialization
    init(journal: JournalModel, journalVM: JournalViewModel) {
        _detailVM = StateObject(
            wrappedValue: JournalDetailViewModel(
                journal: journal, journalViewModel: journalVM))
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            GradientBackground()

            VStack(spacing: 0) {
                // Date display
                HStack {
                    Text("Date:")
                        .foregroundStyle(.secondary)
                    Text(detailVM.date, style: .date)
                }
                .padding(.horizontal)
                .padding(.top, 10)

                // Mood selection
                moodSelection

                // Journal form
                journalForm
            }

            // Floating Action Button
            VStack {
                Spacer()
                FloatingActionButton(
                    action: {
                        if detailVM.saveJournal() {
                            dismiss()
                        }
                    }, icon: "checkmark"
                )
                .disabled(!detailVM.isValid)
            }
            .padding(.trailing, 20)
            .padding(.bottom, 20)
            .padding()
            .frame(maxWidth: .infinity)
            .navigationTitle("Journal Detail")
        }
        .alert("Error", isPresented: $detailVM.showingAlert) {
            Button("OK") {}
        } message: {
            Text(detailVM.alertMessage)
        }
    }
}

// MARK: - View Components
extension JournalDetailView {
    private var moodSelection: some View {
        HStack {
            ForEach(Mood.allCases, id: \.self) { mood in
                Button {
                    detailVM.selectedMood = mood
                } label: {
                    Text(mood.emoji)
                        .font(.largeTitle)
                        .padding()
                        .background(
                            detailVM.selectedMood == mood ? Color.accentColor.opacity(0.3) : .clear
                        )
                        .clipShape(Circle())
                }
            }
        }
        .padding(.top, 20)
    }

    private var journalForm: some View {
        VStack(spacing: 0) {
            TextField("Title", text: $detailVM.title)
                .font(.title)
                .bold()
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10, corners: [.topLeft, .topRight])

            TextEditorWithPlaceholder(text: $detailVM.notes, placeholder: "Write your thoughts...")
                .padding(.horizontal)
                .background(Color.white.opacity(0.1))
                .scrollContentBackground(.hidden)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                .foregroundStyle(Color.theme.secondaryText)
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        NavigationLink(
            destination: JournalDetailView(
                journal: JournalModel(
                    title: "Sample Title",
                    notes: "Sample notes for preview",
                    mood: .happy
                ),
                journalVM: JournalViewModel.preview
            )
        ) {
            Text("Navigate to Detail")
        }
    }
}
