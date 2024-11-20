//
//  NoteEditorView.swift
//  introspec
//
//  Created by Baba Yaga on 30/10/24.
//

import SwiftUI

struct NoteEditorView: View {
    @State var note: Note
    var isNewNote: Bool
    @Environment(\.dismiss) var dismiss
    var onSave: ((_ note: Note) -> Void)? = nil
    var onUpdate: ((_ note: Note) -> Void)? = nil
    
    init(note: Note, isNewNote: Bool, onSave: ((_ note: Note) -> Void)? = nil, onUpdate: ((_ note: Note) -> Void)? = nil) {
        self.note = note
        self.isNewNote = isNewNote
        self.onSave = onSave
        self.onUpdate = onUpdate
    }
    
    var body: some View {
        ZStack {
            Color(.offWhiteBackground)
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                CustomTextEditor(text: $note.content)
                                    .background(Color(.offWhiteBackground))
                                    .cornerRadius(8)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    DispatchQueue.global(qos: .userInitiated).async {
                        if isNewNote {
                            onSave!(note)
                        } else {
                            onUpdate!(note)
                        }
                        dismiss()
                    }
                }
            }
        }
        
    }
}

//#Preview {
//    NoteEditorView(note: ModelData().notes[0], isNewNote: true)
//}
