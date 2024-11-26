//
//  FetchNotesUseCaseImpl.swift
//  introspec
//
//  Created by Baba Yaga on 18/11/24.
//

import Foundation
import Combine

class FetchNotesUseCaseImpl: FetchNotesUseCase {
    private let repository: NoteRepository
    
    init(repository: NoteRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[Note], Error> {
        repository.fetchNotes()
            .eraseToAnyPublisher()
    }
}
