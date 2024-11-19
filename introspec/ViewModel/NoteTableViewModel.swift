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
    @Published var update: Bool = false
    
    init(fetchNotesUseCase: FetchNotesUseCase) {
        self.fetchNotesUseCase = fetchNotesUseCase
        getSavedNotes()
    }
    
    func getSavedNotes() {
        notes.removeAll()
        notes = fetchNotesUseCase.execute()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.update.toggle()
        })
    }
}
