//
//  JournalEmptyView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 16/05/25.
//

import SwiftUI

struct JournalEmptyView: View {
    var onTapAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "note.text.badge.plus")
                .font(.system(size: 70))
                .foregroundColor(.white.opacity(0.8))

            Text("No Entries Yet")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text("Start journaling today by tapping the button below")
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.8))
                .padding(.horizontal, 40)

            Button(action: onTapAction) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.headline)
                    Text("Add Your First Entry")
                        .fontWeight(.semibold)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.ultraThinMaterial)
                )
                .foregroundColor(.white)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

#Preview {
    JournalEmptyView(onTapAction: {})
}
