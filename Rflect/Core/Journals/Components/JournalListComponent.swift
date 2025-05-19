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

    // Add namespace for matchedGeometryEffect
    @Namespace private var animationNamespace

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
                            // Direct call without wrapping in DispatchQueue
                            onDeleteJournal(journal)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                    // Add transition for individual items
                    .transition(
                        .asymmetric(
                            insertion: .scale(scale: 0.9).combined(with: .opacity),
                            removal: .scale(scale: 0.8).combined(with: .opacity)
                        )
                    )
                    // Match geometry effect for smoother animations
                    .matchedGeometryEffect(id: journal.id, in: animationNamespace)
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: journals.count)
        }
        .listStyle(.plain)
        .listRowSpacing(0)
        .scrollContentBackground(.hidden)
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 100)
        }
        // Add animation when the journals collection changes
        .animation(.easeInOut(duration: 0.3), value: journals)
    }
}
