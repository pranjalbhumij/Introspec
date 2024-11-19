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
    let updateNoteUesCase: UpdateNoteUseCase
    let deleteNoteUesCase: DeleteNoteUseCase
    
    init() {
        let context = CoreDataManager.shared(containerName: DBConstants.notesModel, dbPath: PathFactory.getDBPath(dbName: DBConstants.notesDb)).context
        let repository = CoreDataNoteRepository(context: context)
        noteTableViewModel = NoteTableViewModel(fetchNotesUseCase: FetchNotesUseCaseImpl(repository: repository))
        saveNoteUseCase = SaveNoteUseCaseImpl(repository: repository)
        updateNoteUesCase = UpdateNoteUseCaseImpl(repository: repository)
        deleteNoteUesCase = DeleteNoteUseCaseImpl(repository: repository)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(noteTableViewModel: noteTableViewModel, saveNoteUseCase: saveNoteUseCase, updateNoteUesCase: updateNoteUesCase,deleteNoteUseCase: deleteNoteUesCase)
        }
    }
}
