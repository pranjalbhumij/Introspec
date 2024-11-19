//
//  NoteEditorViewModel.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import Foundation
import CoreData

class NoteEditorViewModel: ObservableObject {
    private let saveNoteUseCase: SaveNoteUseCase
    private let updateNoteUseCase: UpdateNoteUseCase
    
    init(saveNoteUseCase: SaveNoteUseCase, updateNoteUseCase: UpdateNoteUseCase) {
        self.saveNoteUseCase = saveNoteUseCase
        self.updateNoteUseCase = updateNoteUseCase
    }
    
    func save(note: Note) {
        saveNoteUseCase.execute(note: note)
    }
    
    func update(note: Note) {
        updateNoteUseCase.execute(note: note)
    }
}
