//
//  EntryListView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftData
import SwiftUI

struct EntryListView: View {
    @EnvironmentObject var viewModel: JournalViewModel
    @Binding var showingEntryForm: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackgroundView(
                    startColor: Color.blue.opacity(0.8),
                    middleColor: Color.blue.opacity(0.6),
                    endColor: Color.blue.opacity(0.2)
                )

                if viewModel.entries.isEmpty {
                    EmptyStateView(onTapAction: {
                        showingEntryForm = true
                    })
                } else {
                    List {
                        ForEach(viewModel.entries) { entry in
                            EntryRowView(entry: entry)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { viewModel.deleteEntry(viewModel.entries[$0]) }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
            }
            .navigationTitle("Rflect")
        }
        .onAppear {
            viewModel.loadEntries()
        }
    }
}

struct EmptyStateView: View {
    var onTapAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "note.text.badge.plus")
                .font(.system(size: 70))
                .foregroundColor(.white.opacity(0.8))

            Text("No Entries Yet")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text("Start journaling today by tapping the button below")
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.8))
                .padding(.horizontal, 40)

            Button(action: onTapAction) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.headline)
                    Text("Add Your First Entry")
                        .fontWeight(.semibold)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.ultraThinMaterial)
                )
                .foregroundColor(.white)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

#Preview {
    EntryListView(showingEntryForm: .constant(false))
        .environmentObject(JournalViewModel.preview)
}
