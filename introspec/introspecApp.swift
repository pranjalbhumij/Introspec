//
//  introspecApp.swift
//  introspec
//
//  Created by Baba Yaga on 30/10/24.
//

import SwiftUI

@main
struct introspecApp: App {
    let noteTableViewModel: NoteTableViewModel
    let saveNoteUseCase: SaveNoteUseCase
    let updateNoteUseCase: UpdateNoteUseCase
    let deleteNoteUseCase: DeleteNoteUseCase
    let fetchNoteUseCase: FetchNotesUseCase
    
    init() {
        let context = CoreDataManager.shared(containerName: DBConstants.notesModel, dbPath: PathFactory.getDBPath(dbName: DBConstants.notesDb)).context
        let repository = CoreDataNoteRepository(context: context)
        fetchNoteUseCase = FetchNotesUseCaseImpl(repository: repository)
        saveNoteUseCase = SaveNoteUseCaseImpl(repository: repository)
        updateNoteUseCase = UpdateNoteUseCaseImpl(repository: repository)
        deleteNoteUseCase = DeleteNoteUseCaseImpl(repository: repository)
        noteTableViewModel = NoteTableViewModel(fetchNotesUseCase: fetchNoteUseCase,
                                                deleteNoteUseCase: deleteNoteUseCase,
                                                updateNoteUseCase: updateNoteUseCase,
                                                saveNoteUseCase: saveNoteUseCase
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(noteTableViewModel: noteTableViewModel, saveNoteUseCase: saveNoteUseCase, updateNoteUesCase: updateNoteUseCase,deleteNoteUseCase: deleteNoteUseCase)
        }
    }
    
}
