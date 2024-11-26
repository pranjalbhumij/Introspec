//
//  UpdateNoteUseCaseImpl.swift
//  introspec
//
//  Created by Baba Yaga on 18/11/24.
//

import Foundation
import Combine

class UpdateNoteUseCaseImpl: UpdateNoteUseCase {
    private let repository: NoteRepository
    
    init(repository: NoteRepository) {
        self.repository = repository
    }
    
    func execute(note: Note) -> AnyPublisher<Void, Error> {
        repository.update(note: note)
            .eraseToAnyPublisher()
    }
}
