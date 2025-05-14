//
//  EntryFormView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftUI
import SwiftData

struct EntryFormView: View {
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
        VStack(spacing: 0) {
            Text("How's today?")
                .font(.title)
                .bold()
                .padding(.top, 10)
            
            // Date picker
            DatePicker("Date", selection: $entryDate, displayedComponents: [.date])
                .padding(.horizontal)
                .padding(.top, 10)
            
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
            
            VStack(spacing: 0) {
                TextField("Title", text: $title)
                    .font(.title)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10, corners: [.topLeft, .topRight])
                
                TextEditorWithPlaceholder(text: $notes, placeholder: "Describe your day..")
                    .padding(.horizontal)
                    .background(Color.white.opacity(0.1))
                    .scrollContentBackground(.hidden)
                    .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Spacer()
            
            Button(action: {
                viewModel.addEntry(title: title, notes: notes, mood: selectedMood, date: entryDate)
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
            .buttonStyle(.borderedProminent)
            .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
            .padding(.bottom)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.5))
                )
        )
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                XMarkButton {
                    dismiss()
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

// Custom RoundedCorner shape for applying different corner radiuses
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// Extension to make the shape modifier easier to use
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

#Preview {
    EntryFormView(initialDate: nil)
        .environmentObject(JournalViewModel.preview)
}
