//
//  HomeViewModel.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var showingJournalForm = false
    @Published var showingSettings = false
    @Published var selectedJournal: JournalModel?
    @Published var isShowingDetail = false
    @Published var selectedTab: Tab = .list
    @Published var showDeleteConfirmation = false
    @Published var journalToDelete: JournalModel? = nil

    static var preview: HomeViewModel {
        let vm = HomeViewModel()
        // Add any preview data if needed
        return vm
    }

}
