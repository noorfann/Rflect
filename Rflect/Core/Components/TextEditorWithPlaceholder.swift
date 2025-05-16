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
        ZStack(alignment: .leading) {
            if text.isEmpty {
               VStack {
                    Text(placeholder)
                        .padding(.top, 10)
                        .padding(.leading, 6)
                        .opacity(0.4)
                    Spacer()
                }
            }
            
            VStack {
                TextEditor(text: $text)
                    .frame(minHeight: 150, maxHeight: 300)
                    .opacity(text.isEmpty ? 0.85 : 1)
                Spacer()
            }
        }
    }
}

#Preview {
    TextEditorWithPlaceholder(text: .constant(""), placeholder: "This is a placeholder..")
}
