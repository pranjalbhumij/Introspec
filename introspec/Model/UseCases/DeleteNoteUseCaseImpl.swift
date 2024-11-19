//
//  DeleteNoteUseCaseImpl.swift
//  introspec
//
//  Created by Baba Yaga on 19/11/24.
//

import Foundation

class DeleteNoteUseCaseImpl: DeleteNoteUseCase {
    private let repository: CoreDataNoteRepository
    
    init(repository: CoreDataNoteRepository) {
        self.repository = repository
    }
    
    func execute(id: String) {
        repository.delete(id: id)
    }
    
    
}
