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
    
    init(fetchNotesUseCase: FetchNotesUseCase) {
        self.fetchNotesUseCase = fetchNotesUseCase
        getSavedNotes()
    }
    
    func getSavedNotes() {
        notes.removeAll()
        DispatchQueue.main.async { [weak self] in
            self?.notes = self?.fetchNotesUseCase.execute() ?? []
        }
    }
}
