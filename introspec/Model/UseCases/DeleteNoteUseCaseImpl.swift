//
//  DeleteNoteUseCaseImpl.swift
//  introspec
//
//  Created by Baba Yaga on 19/11/24.
//

import Foundation
import Combine

class DeleteNoteUseCaseImpl: DeleteNoteUseCase {
    private let repository: CoreDataNoteRepository
    
    init(repository: CoreDataNoteRepository) {
        self.repository = repository
    }
    
    func execute(id: String) -> AnyPublisher<Void, Error> {
        repository.delete(id: id)
            .eraseToAnyPublisher()
    }
    
    
}
