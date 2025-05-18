//
//  SettingsView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 17/05/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var settings: SettingsViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Journal") {
                    Toggle("Show Title on Journal Form", isOn: $settings.showJournalTitle)
                }

                Section("Templates") {
                    NavigationLink {
                        TemplatesView()
                    } label: {
                        Label("Manage Templates", systemImage: "doc.text")
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    XMarkButton {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
}
