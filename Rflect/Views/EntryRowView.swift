//
//  EntryRowView.swift
//  Rflect
//
//  Created by Zulfikar Noorfan on 14/05/25.
//

import SwiftUI

struct EntryRowView: View {
    let entry: JournalEntry
    
    var body: some View {
        HStack (alignment: .top, spacing: 12) {
            Text(entry.mood.emoji)
                .font(.largeTitle)
                .padding(8)
                .background(Color.accentColor.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.title)
                    .font(.headline)
    
                Text(entry.notes)
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundColor(.secondary)
                
                Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
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

#Preview {
    EntryRowView(entry: JournalEntry(title: "Test journal", notes: "This is today journal", mood: .happy))
        .padding()
        .background(Color.gray.opacity(0.2))
        .previewLayout(.sizeThatFits)
}
