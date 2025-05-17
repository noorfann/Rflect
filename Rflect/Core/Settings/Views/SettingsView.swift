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

                Section(
                    footer: Text(
                        "These colors will be applied to all gradient backgrounds in the app.")
                ) {
                    ColorPicker("Start Color", selection: $settings.gradientStartColor)
                    ColorPicker("Middle Color", selection: $settings.gradientMiddleColor)
                    ColorPicker("End Color", selection: $settings.gradientEndColor)

                    Button(role: .destructive) {
                        settings.resetColors()
                    } label: {
                        Text("Reset to Default Colors")
                    }

                    // Preview
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Preview")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        settings.gradientStartColor,
                                        settings.gradientMiddleColor,
                                        settings.gradientEndColor,
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 100)
                    }
                    .padding(.top, 8)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
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
