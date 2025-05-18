//
//  TemplateBrowserView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 17/05/25.
//

import SwiftUI

struct TemplateBrowserView: View {
    @EnvironmentObject private var templateVM: TemplateViewModel
    @State private var selectedCategory: TemplateCategory?
    @State private var searchText = ""

    private var filteredTemplates: [TemplateModel] {
        let templates = templateVM.templates(for: selectedCategory)
        if searchText.isEmpty {
            return templates
        }
        return templates.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
                || $0.notes.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Category picker
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    categoryButton(nil, "All")
                    ForEach(TemplateCategory.allCases, id: \.self) { category in
                        categoryButton(category, category.description)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 8)

            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("Search templates...", text: $searchText)
            }
            .padding(8)
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(8)
            .padding(.horizontal)

            // Templates grid
            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                    ], spacing: 16
                ) {
                    ForEach(filteredTemplates, id: \.id) { template in
                        TemplateCard(template: template)
                    }
                }
                .padding()
            }
        }
    }

    private func categoryButton(_ category: TemplateCategory?, _ title: String) -> some View {
        Button {
            withAnimation {
                selectedCategory = category
            }
        } label: {
            Text(title)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(selectedCategory == category ? Color.accentColor : Color.clear)
                .foregroundColor(selectedCategory == category ? .white : .primary)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.accentColor, lineWidth: 1)
                )
        }
    }
}

struct TemplateCard: View {
    let template: TemplateModel
    @EnvironmentObject private var templateVM: TemplateViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: template.category.systemImageName)
                Text(template.category.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }

            Text(template.title)
                .font(.headline)
                .lineLimit(2)

            Text(template.preview)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)

            Spacer()

            Button {
                if template.isAdded {
                    templateVM.removeFromCollection(template)
                } else {
                    templateVM.addToCollection(template)
                }
            } label: {
                HStack {
                    Image(systemName: template.isAdded ? "minus.circle" : "plus.circle")
                    Text(template.isAdded ? "Remove" : "Add")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(height: 200)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}

struct TemplateBrowserView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateBrowserView()
            .environmentObject(TemplateViewModel.preview)
    }
}
