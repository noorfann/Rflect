//
//  TemplateViewModel.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 17/05/25.
//

import Foundation
import SwiftData


@MainActor
class TemplateViewModel: ObservableObject {
    private var context: ModelContext

    @Published var templates: [TemplateModel] = []
    @Published var userTemplates: [TemplateModel] = []
    @Published var selectedCategory: TemplateCategory?

    // MARK: - Initialization

    init(context: ModelContext) {
        self.context = context
        loadTemplates()
        addDefaultTemplatesIfNeeded()
    }

    // MARK: - Data Operations

    func loadTemplates() {
        let descriptor = FetchDescriptor<TemplateModel>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )

        do {
            templates = try context.fetch(descriptor)
            updateUserTemplates()
        } catch {
            print("Error loading templates: \(error)")
        }
    }

    private func updateUserTemplates() {
        userTemplates = templates.filter { $0.isAdded || $0.isCustom }
    }

    func addToCollection(_ template: TemplateModel) {
        template.isAdded = true
        save()
        updateUserTemplates()
    }

    func removeFromCollection(_ template: TemplateModel) {
        if template.isCustom {
            deleteTemplate(template)
        } else {
            template.isAdded = false
            save()
        }
        updateUserTemplates()
    }

    func createTemplate(
        title: String, notes: String, category: TemplateCategory, customTags: [String] = []
    ) {
        let template = TemplateModel(
            title: title,
            notes: notes,
            category: category,
            customTags: customTags,
            isCustom: true,
            isAdded: true
        )

        context.insert(template)
        save()
        loadTemplates()
    }

    func updateTemplate(_ template: TemplateModel) {
        save()
        loadTemplates()
    }

    func deleteTemplate(_ template: TemplateModel) {
        context.delete(template)
        save()
        loadTemplates()
    }

    // MARK: - Filtering

    func templates(for category: TemplateCategory?) -> [TemplateModel] {
        guard let category = category else {
            return templates
        }
        return templates.filter { $0.category == category }
    }

    func userTemplates(for category: TemplateCategory?) -> [TemplateModel] {
        guard let category = category else {
            return userTemplates
        }
        return userTemplates.filter { $0.category == category }
    }

    // MARK: - Helpers

    private func save() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

// MARK: - Preview Provider
extension TemplateViewModel {
    static var preview: TemplateViewModel {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: TemplateModel.self, configurations: config)
        let context = ModelContext(container)

        // Add sample templates
        for template in TemplateModel.defaultTemplates {
            context.insert(template)
        }

        return TemplateViewModel(context: context)
    }
}

// MARK: - Default Templates
extension TemplateViewModel {
    func addDefaultTemplatesIfNeeded() {
        // First check if we have any templates at all
        let descriptor = FetchDescriptor<TemplateModel>()
        
        do {
            let count = try context.fetchCount(descriptor)
            
            // Only add default templates if no templates exist
            if count == 0 {
                for template in TemplateModel.defaultTemplates {
                    let defaultTemplate = TemplateModel(
                        title: template.title,
                        notes: template.notes,
                        category: template.category,
                        customTags: template.customTags,
                        isCustom: false,
                        isAdded: false
                    )
                    context.insert(defaultTemplate)
                }
                save()
                loadTemplates()
            }
        } catch {
            print("Error checking for existing templates: \(error)")
        }
    }
}
