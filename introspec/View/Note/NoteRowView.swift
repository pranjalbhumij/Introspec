//
//  NoteRowView.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import SwiftUI

struct NoteRowView: View {
    @Binding var note: Note
    let onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title).font(.headline)
                .foregroundColor(.primaryText)
            HStack {
                Text(note.dateModified.formattedDate()).font(.subheadline)
                    .foregroundColor(.secondaryText)
                Text(removeTitle(note.content))
                    .font(.subheadline)
                        .foregroundColor(.secondaryText)
                        .lineLimit(1)
                                .truncationMode(.tail)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contextMenu {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Text("Delete")
            }
        }
    }
    
    private func removeTitle(_ content: String) -> String {
        var newContent = ""
        if let titleRange = content.range(of: note.title) {
            newContent = content.replacingCharacters(in: titleRange, with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            newContent = content
        }
        return newContent
    }
}

#Preview {
    let mockNote = Note(
            id: "1",
            title: "Sample Note Title",
            content: "Sample Note Title\n This is the content of the sample note",
            dateCreation: "2024-11-01",
            dateModified: "2024-11-15"
        )
    return NoteRowView(note: .constant(mockNote), onDelete: {})
}

