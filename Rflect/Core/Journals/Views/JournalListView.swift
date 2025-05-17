//
//  JournalListView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftData
import SwiftUI

struct JournalListView: View {
    @EnvironmentObject private var journalVM: JournalViewModel
    @EnvironmentObject private var homeVM: HomeViewModel

    var body: some View {
        ZStack(alignment: .center) {
            GradientBackground(
                startColor: Color.theme.background.opacity(0.1),
                middleColor: Color.theme.background.opacity(0.6),
                endColor: Color.theme.accent.opacity(0.8)
            )
            if journalVM.journals.isEmpty {
                JournalEmptyView(onTapAction: {
                    homeVM.showingJournalForm = true
                })
            } else {
                List(journalVM.journals) { journal in
                    JournalRowView(journal: journal)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            homeVM.selectedJournal = journal
                            homeVM.isShowingDetail = true
                        }
                }
                .listStyle(.plain)
                .listRowSpacing(0)
            }

            FloatingActionButton(action: {
                homeVM.showingJournalForm = true
            })
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
    }
}

#Preview {
    NavigationStack {
        JournalListView()
            .environmentObject(JournalViewModel.preview)
            .environmentObject(HomeViewModel.preview)
    }
}
