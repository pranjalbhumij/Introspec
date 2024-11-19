//
//  NoteTableViewModel.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import Foundation
import CoreData

class NoteTableViewModel: ObservableObject {
    @Published var notes: [Note] = []
    private let fetchNotesUseCase: FetchNotesUseCase
    private let deleteNoteUseCase: DeleteNoteUseCase
    private let updateNoteUseCase: UpdateNoteUseCase
    private let saveNoteUseCase: SaveNoteUseCase
    
    init(fetchNotesUseCase: FetchNotesUseCase, deleteNoteUseCase: DeleteNoteUseCase, updateNoteUseCase: UpdateNoteUseCase, saveNoteUseCase: SaveNoteUseCase) {
        self.fetchNotesUseCase = fetchNotesUseCase
        self.deleteNoteUseCase = deleteNoteUseCase
        self.updateNoteUseCase = updateNoteUseCase
        self.saveNoteUseCase = saveNoteUseCase
        getSavedNotes()
    }
    
    func getSavedNotes() {
        notes.removeAll()
        DispatchQueue.main.async { [weak self] in
            self?.notes = self?.fetchNotesUseCase.execute() ?? []
        }
    }
    
    func deleteNote(id: String) {
        deleteNoteUseCase.execute(id: id)
        self.notes.removeAll(where: { note in
            note.id == id
        })
    }
    
    func saveNote(note: Note) {
        saveNoteUseCase.execute(note: note)
        notes.append(note)
    }
    
    func updateNote(note: Note) {
        updateNoteUseCase.execute(note: note)
        self.notes.removeAll(where: { note in
            note.id == note.id
        })
        self.notes.append(note)
    }
}
