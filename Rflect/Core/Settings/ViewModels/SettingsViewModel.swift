//
//  SettingsViewModel.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 17/05/25.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    // Title visibility setting
    @AppStorage("showJournalTitle") var showJournalTitle = true
}
