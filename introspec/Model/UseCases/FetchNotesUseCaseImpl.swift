//
//  FetchNotesUseCaseImpl.swift
//  introspec
//
//  Created by Baba Yaga on 18/11/24.
//

import Foundation

class FetchNotesUseCaseImpl: FetchNotesUseCase {
    private let repository: NoteRepository
    
    init(repository: NoteRepository) {
        self.repository = repository
    }
    
    func execute() -> [Note] {
        return repository.fetchNotes()
    }
}