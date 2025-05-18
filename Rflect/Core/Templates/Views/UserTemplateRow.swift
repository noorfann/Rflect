//
//  UserTemplateRow.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 18/05/25.
//

import SwiftUI

struct UserTemplateRow: View {
    let template: TemplateModel
    let onEdit: () -> Void
    @EnvironmentObject private var templateVM: TemplateViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(template.title)
                    .font(.headline)
                HStack {
                    Image(systemName: template.category.systemImageName)
                    Text(template.category.description)
                        .font(.caption)
                }
                .foregroundColor(.secondary)
            }

            Spacer()

            Menu {
                if template.isCustom {
                    Button {
                        onEdit()
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                }

                Button(role: .destructive) {
                    templateVM.removeFromCollection(template)
                } label: {
                    Label(
                        template.isCustom ? "Delete" : "Remove",
                        systemImage: template.isCustom ? "trash" : "minus.circle"
                    )
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
#Preview {
    UserTemplateRow(template: TemplateModel.previewTemplate) {
        
    }
}
