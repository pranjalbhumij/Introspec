//
//  NoteEditorView.swift
//  introspec
//
//  Created by Baba Yaga on 30/10/24.
//

import SwiftUI

struct NoteEditorView: View {
    @State var note: Note
    @FocusState var focus: Bool
    @StateObject private var viewModel: NoteEditorViewModel
    var isNewNote: Bool
    
    init(note: Note, isNewNote: Bool, viewModel: NoteEditorViewModel) {
        self.note = note
        self.isNewNote = isNewNote
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color(.offWhiteBackground)
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                TextEditor(text: $note.content)
                    .scrollContentBackground(.hidden)
                    .background(Color(.offWhiteBackground))
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .focused($focus)
                    .onAppear {
                        focus = true
                    }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if isNewNote {
                        viewModel.save(note: note)
                    } else {
                        viewModel.update(note: note)
                    }
                }
            }
        }
        
    }
}

//#Preview {
//    NoteEditorView(note: ModelData().notes[0], isNewNote: true)
//}
