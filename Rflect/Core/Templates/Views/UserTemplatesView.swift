//
//  UserTemplatesView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 17/05/25.
//

import SwiftUI

struct UserTemplatesView: View {
    @EnvironmentObject private var templateVM: TemplateViewModel
    @State private var selectedCategory: TemplateCategory?
    @State private var editingTemplate: TemplateModel?

    var body: some View {
        Group {
            if templateVM.userTemplates.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "folder")
                        .font(.system(size: 50))
                        .foregroundColor(.secondary)
                    Text("No Templates Yet")
                        .font(.headline)
                    Text("Add templates from the browser or create your own")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
            } else {
                List {
                    ForEach(templateVM.userTemplates, id: \.id) { template in
                        UserTemplateRow(template: template) {
                            editingTemplate = template
                        }
                    }
                }
            }
        }
        .sheet(item: $editingTemplate) { template in
            NavigationView {
                TemplateFormView(mode: .edit(template))
            }
        }
    }
}

struct UserTemplatesView_Previews: PreviewProvider {
    static var previews: some View {
        UserTemplatesView()
            .environmentObject(TemplateViewModel.preview)
    }
}
