//
//  JournalRowView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftUI

struct JournalRowView: View {
    let journal: JournalModel
    
    var body: some View {
        HStack (alignment: .top, spacing: 12) {
            emojisView
            formView
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.3))
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

extension JournalRowView {
    private var emojisView: some View {
        Text(journal.mood.emoji)
            .font(.largeTitle)
            .padding(8)
            .background(Color.accentColor.opacity(0.2))
            .clipShape(Circle())
    }
    
    private var formView: some View {
        VStack(alignment: .leading, spacing: 4) {
            if journal.title != "" {
                Text(journal.title)
                    .font(.headline)
            }

            Text(journal.notes)
                .font(.subheadline)
                .lineLimit(2)
                .foregroundColor(.secondary)
            
            Text(journal.date.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    JournalRowView(journal: JournalModel(title: "Test journal", notes: "This is today journal", mood: .happy))
        .padding()
        .background(Color.gray.opacity(0.2))
}
