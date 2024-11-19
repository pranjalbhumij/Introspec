//
//  NoteRowView.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import SwiftUI

struct NoteRowView: View {
    @Binding var note: Note
    private let deleteUseCase: DeleteNoteUseCase
    //@Binding var id: Bool
    @ObservedObject var viewModel: NoteTableViewModel
    
    init(note: Binding<Note>, deleteUseCase: DeleteNoteUseCase, viewModel: NoteTableViewModel) {
        self._note = note
        self.deleteUseCase = deleteUseCase
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(note.title).font(.headline)
                    .foregroundColor(.primaryText)
            }
            Text(note.dateModified.formattedDate()).font(.caption)
                .foregroundColor(.secondaryText)
            
        }
        .onAppear {
            print (note.title)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contextMenu {
            Button(role: .destructive) {
                self.deleteUseCase.execute(id: self.note.id)
                viewModel.notes.removeAll(where: { note in
                    note.id == self.note.id
                })
            } label: {
                Text("Delete")
            }
        }
        
    }
}

//#Preview {
//    NoteRowView(note: ModelData().notes[0], id: .constant(false))
//}
