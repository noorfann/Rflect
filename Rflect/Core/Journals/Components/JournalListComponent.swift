//
//  JournalListComponent.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 19/05/25.
//

import SwiftUI

struct JournalListComponent: View {
    let journals: [JournalModel]
    let onTapJournal: (JournalModel) -> Void
    let onDeleteJournal: (JournalModel) -> Void
    
    var body: some View {
        List {
            ForEach(journals) { journal in
                JournalCell(journal: journal)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onTapJournal(journal)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            // Use DispatchQueue to move the state changes out of the view update cycle
                            DispatchQueue.main.async {
                                onDeleteJournal(journal)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
            }
        }
        .listStyle(.plain)
        .listRowSpacing(0)
        .scrollContentBackground(.hidden)
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 100)
        }
    }
}
