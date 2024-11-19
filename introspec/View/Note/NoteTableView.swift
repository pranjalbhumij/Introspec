//
//  NoteTableView.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import SwiftUI

struct NoteTableView: View {
    @StateObject var viewModel: NoteTableViewModel
    private let saveNoteUseCase: SaveNoteUseCase
    private let updateNoteUseCase: UpdateNoteUseCase
    private let deleteNoteUseCase: DeleteNoteUseCase
    @State private var isNewNote = false
    @State private var selectedNote: Note? = nil
    
    public init(viewModel: NoteTableViewModel, saveNoteUseCase: SaveNoteUseCase, updateNoteUseCase: UpdateNoteUseCase,
                deleteNoteUseCase: DeleteNoteUseCase, isNewNote: Bool = false, selectedNote: Note? = nil) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.saveNoteUseCase = saveNoteUseCase
        self.updateNoteUseCase = updateNoteUseCase
        self.deleteNoteUseCase = deleteNoteUseCase
        self._isNewNote = State(initialValue: isNewNote)
        self._selectedNote = State(initialValue: selectedNote)
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach($viewModel.notes, id: \.id) { $note in
                    NavigationLink(value: note) {
                        NoteRowView(note: $note, deleteUseCase: deleteNoteUseCase, viewModel: viewModel)
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
                    viewModel: NoteEditorViewModel(
                        saveNoteUseCase: self.saveNoteUseCase,
                        updateNoteUseCase: self.updateNoteUseCase
                    )
                )
            }
            .navigationDestination(for: Note.self) {note in
                NoteEditorView(note: note, isNewNote: false, viewModel: NoteEditorViewModel(
                    saveNoteUseCase: self.saveNoteUseCase,
                    updateNoteUseCase: self.updateNoteUseCase
                ))
                .onDisappear {
                    selectedNote = nil
                }
            }
            .onAppear {
                selectedNote = nil
                viewModel.getSavedNotes()
            }
        } detail: {
            Text("Select a note")
        }
    }
}


//#Preview {
//    NoteTableView(viewModel: NoteTableViewModel())
//}
