//
//  NoteTableView.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import SwiftUI

struct NoteTableView: View {
    @StateObject var viewModel: NoteTableViewModel
    @State private var isNewNote = false
    
    public init(viewModel: NoteTableViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach($viewModel.notes, id: \.id) { $note in
                    NavigationLink(value: note) {
                        NoteRowView(note: $note, onDelete: { viewModel.deleteNote(id: note.id) } )
                            .frame(height: 40)
                    }
                    .tag(note)
                }
                
            }
            .listRowSpacing(10)
            .background(Color("offWhiteBackground"))
            .scrollContentBackground(.hidden)
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isNewNote = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(isPresented: $isNewNote) {
                NoteEditorView(
                    note: Note(
                        id: UUID().uuidString,
                        title: "",
                        content: "",
                        dateCreation: Date().toString(),
                        dateModified: Date().toString()
                    ),
                    isNewNote: true,
                    onSave: { note in
                        viewModel.saveNote(note: note)
                    }
                )
            }
            .navigationDestination(for: Note.self) {note in
                NoteEditorView(note: note, isNewNote: false, onUpdate: { note in
                    viewModel.updateNote(note: note)
                })
            }
            .onAppear {
                viewModel.getSavedNotes()
            }
        } detail: {
            Text("Select a note")
        }
        .tint(Color("toolbarColor"))
    }
}


//#Preview {
//    NoteTableView(viewModel: NoteTableViewModel())
//}
