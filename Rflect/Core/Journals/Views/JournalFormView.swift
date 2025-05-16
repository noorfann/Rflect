//
//  JournalFormView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftUI
import SwiftData

struct JournalFormView: View {
    @EnvironmentObject var viewModel: JournalViewModel
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
            VStack(spacing: 0) {
                datePicker
                
                // select mood of todays
                moodSelection
                
                // insert journal with title and titleDesc
                journalForm
                
                Spacer()
                
                // submit journal
                submitButton
            }
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
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.2))
                )
        )
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
            TextField("Title", text: $title)
                .font(.title)
                .bold()
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10, corners: [.topLeft, .topRight])
            
            TextEditorWithPlaceholder(text: $notes, placeholder: "Describe your day..")
                .padding(.horizontal)
                .background(Color.white.opacity(0.1))
                .scrollContentBackground(.hidden)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                .foregroundStyle(Color.theme.secondaryText)
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    private var submitButton: some View {
        Button(action: {
            viewModel.addJournal(title: title, notes: notes, mood: selectedMood, date: entryDate)
            dismiss()
        }) {
            Text("Save")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
        }
        .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
        .padding(.bottom)
    }
}
