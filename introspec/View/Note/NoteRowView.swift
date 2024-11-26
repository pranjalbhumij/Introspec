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
            HStack {
                Text(note.title).font(.headline)
                    .foregroundColor(.primaryText)
            }
            Text(note.dateModified.formattedDate()).font(.caption)
                .foregroundColor(.secondaryText)
            
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
}

#Preview {
    let mockNote = Note(
            id: "1",
            title: "Sample Note Title",
            content: "This is the content of the sample note.",
            dateCreation: "2024-11-01",
            dateModified: "2024-11-15"
        )
    return NoteRowView(note: .constant(mockNote), onDelete: {})
}

