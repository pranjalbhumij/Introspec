//
//  ContentView.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import SwiftUI

struct ContentView: View {
    let noteTableViewModel: NoteTableViewModel
    let saveNoteUseCase: SaveNoteUseCase
    let updateNoteUesCase: UpdateNoteUseCase
    let deleteNoteUesCase: DeleteNoteUseCase
    
    init(noteTableViewModel: NoteTableViewModel, saveNoteUseCase: SaveNoteUseCase, updateNoteUesCase: UpdateNoteUseCase, deleteNoteUseCase: DeleteNoteUseCase) {
        self.noteTableViewModel = noteTableViewModel
        self.saveNoteUseCase = saveNoteUseCase
        self.updateNoteUesCase = updateNoteUesCase
        self.deleteNoteUesCase = deleteNoteUseCase
    }

    var body: some View {
        NoteTableView(viewModel: noteTableViewModel, saveNoteUseCase: saveNoteUseCase, updateNoteUseCase: updateNoteUesCase, deleteNoteUseCase: deleteNoteUesCase)
    }
}

//#Preview {
//    ContentView(noteTableViewModel: <#T##NoteTableViewModel#>, saveNoteUseCase: <#T##any SaveNoteUseCase#>, updateNoteUesCase: <#T##any UpdateNoteUseCase#>)
//}
