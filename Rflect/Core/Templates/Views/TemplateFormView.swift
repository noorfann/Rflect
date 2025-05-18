//
//  TemplateFormView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 17/05/25.
//

import SwiftUI

enum TemplateFormMode {
    case create
    case edit(TemplateModel)
}

struct TemplateFormView: View {
    @EnvironmentObject private var templateVM: TemplateViewModel
    @Environment(\.dismiss) private var dismiss

    let mode: TemplateFormMode

    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var category: TemplateCategory = .custom
    @State private var tags: String = ""
    @State private var showValidationAlert = false

    private var isEditing: Bool {
        if case .edit = mode {
            return true
        }
        return false
    }

    var body: some View {
        Form {
            Section("Template Details") {
                TextField("Title", text: $title)
                    .textInputAutocapitalization(.words)

                Picker("Category", selection: $category) {
                    ForEach(TemplateCategory.allCases, id: \.self) { category in
                        Text(category.description)
                            .tag(category)
                    }
                }

                TextField("Tags (comma separated)", text: $tags)
                    .textInputAutocapitalization(.never)
            }

            Section("Content") {
                TextEditor(text: $notes)
                    .frame(minHeight: 200)

                Text("\(notes.count)/\(TemplateModel.maxNotesLength) characters")
                    .font(.caption)
                    .foregroundColor(notes.count > TemplateModel.maxNotesLength ? .red : .secondary)
            }

            Section {
                Button(action: saveTemplate) {
                    Text(isEditing ? "Update Template" : "Create Template")
                        .frame(maxWidth: .infinity)
                }
                .disabled(!isValid)
            }
        }
        .navigationTitle(isEditing ? "Edit Template" : "New Template")
        .alert("Invalid Template", isPresented: $showValidationAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Please check the title and content length.")
        }
        .onAppear {
            if case .edit(let template) = mode {
                title = template.title
                notes = template.notes
                category = template.category
                tags = template.customTags.joined(separator: ", ")
            }
        }
    }

    private var isValid: Bool {
        !title.isEmpty && title.count <= TemplateModel.maxTitleLength && !notes.isEmpty
            && notes.count <= TemplateModel.maxNotesLength
    }

    private func saveTemplate() {
        let customTags =
            tags
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }

        if case .edit(let template) = mode {
            template.title = title
            template.notes = notes
            template.category = category
            template.customTags = customTags
            templateVM.updateTemplate(template)
        } else {
            templateVM.createTemplate(
                title: title,
                notes: notes,
                category: category,
                customTags: Array(customTags.prefix(TemplateModel.maxCustomTags))
            )
        }

        dismiss()
    }
}

struct TemplateFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TemplateFormView(mode: .create)
                .environmentObject(TemplateViewModel.preview)
        }
    }
}
