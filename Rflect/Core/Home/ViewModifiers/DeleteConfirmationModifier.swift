//
//  DeleteConfirmationModifier.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 19/05/25.
//

import SwiftUI

struct DeleteConfirmationModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var itemToDelete: JournalModel?
    var onDelete: (JournalModel) -> Void

    func body(content: Content) -> some View {
        content
            .alert(
                "Delete Journal?", isPresented: $isPresented,
                actions: {
                    Button("Cancel", role: .cancel) {
                        isPresented = false
                        // Reset after alert is dismissed
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            itemToDelete = nil
                        }
                    }
                    Button("Delete", role: .destructive) {
                        if let item = itemToDelete {
                            onDelete(item)
                        }
                        isPresented = false
                        // Reset after alert is dismissed
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            itemToDelete = nil
                        }
                    }
                },
                message: {
                    Text(
                        "Are you sure you want to delete this journal? This action cannot be undone."
                    )
                })
    }
}

extension View {
    func deleteConfirmation(
        isPresented: Binding<Bool>,
        itemToDelete: Binding<JournalModel?>,
        onDelete: @escaping (JournalModel) -> Void
    ) -> some View {
        self.modifier(
            DeleteConfirmationModifier(
                isPresented: isPresented,
                itemToDelete: itemToDelete,
                onDelete: onDelete
            ))
    }
}
