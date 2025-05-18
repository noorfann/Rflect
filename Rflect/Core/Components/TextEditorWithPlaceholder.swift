//
//  TextEditorWithPlaceholder.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftUI

struct TextEditorWithPlaceholder: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        ZStack(alignment: .topLeading) {  // Change to topLeading
            if text.isEmpty {
                Text(placeholder)
                    .padding(.top, 10)
                    .padding(.leading, 6)
                    .opacity(0.4)
            }

            TextEditor(text: $text)
                .opacity(text.isEmpty ? 0.85 : 1)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .scrollContentBackground(.hidden)
            // Remove fixed height constraints
        }
        .frame(maxWidth: .infinity, minHeight: 150)
    }
}

#Preview {
    TextEditorWithPlaceholder(text: .constant(""), placeholder: "This is a placeholder..")
}
