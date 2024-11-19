//
//  NoteEditorView.swift
//  introspec
//
//  Created by Baba Yaga on 30/10/24.
//

import SwiftUI

struct NoteEditorView: View {
    @State var note: Note
    @State private var focus: Bool = false
    @StateObject private var viewModel: NoteEditorViewModel
    var isNewNote: Bool
    @Environment(\.dismiss) var dismiss
    
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
                CustomTextEditor(text: $note.content, isFocused: $focus)
                                    .background(Color(.offWhiteBackground))
                                    .cornerRadius(8)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .onAppear {
                                        focus = true
                                    }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    DispatchQueue.global(qos: .userInitiated).async {
                        if isNewNote {
                            viewModel.save(note: note)
                        } else {
                            viewModel.update(note: note)
                        }
                        focus = false
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
