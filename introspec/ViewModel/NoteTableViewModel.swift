//
//  NoteTableViewModel.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import Foundation
import CoreData
import Combine

class NoteTableViewModel: ObservableObject {
    @Published var notes: [Note] = []
    private let fetchNotesUseCase: FetchNotesUseCase
    private let deleteNoteUseCase: DeleteNoteUseCase
    private let updateNoteUseCase: UpdateNoteUseCase
    private let saveNoteUseCase: SaveNoteUseCase
    private var cancellable = Set<AnyCancellable>()
    
    init(fetchNotesUseCase: FetchNotesUseCase, deleteNoteUseCase: DeleteNoteUseCase, updateNoteUseCase: UpdateNoteUseCase, saveNoteUseCase: SaveNoteUseCase) {
        self.fetchNotesUseCase = fetchNotesUseCase
        self.deleteNoteUseCase = deleteNoteUseCase
        self.updateNoteUseCase = updateNoteUseCase
        self.saveNoteUseCase = saveNoteUseCase
        getSavedNotes()
    }
    
    func getSavedNotes() {
        notes.removeAll()
        self.fetchNotesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(_) = completion {
                    self?.notes = []
                }
            }, receiveValue: { [weak self] value in
                self?.notes = value
            })
            .store(in: &cancellable)
    }
    
    func deleteNote(id: String) {
        self.deleteNoteUseCase.execute(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .finished = completion {
                    self?.notes.removeAll(where: { note in
                        note.id == id
                    })
                }
            }, receiveValue: { _ in })
            .store(in: &cancellable)
    }
    
    func saveNote(note: Note) {
        self.saveNoteUseCase.execute(note: note)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .finished = completion {
                    self?.notes.append(note)
                }
            }, receiveValue: { _ in })
            .store(in: &cancellable)
        
    }
    
    func updateNote(note: Note) {
        self.updateNoteUseCase.execute(note: note)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] completion in
                if case .finished = completion {
                    self?.notes.removeAll(where: { note in
                        note.id == note.id
                    })
                    self?.notes.append(note)
                }
            }, receiveValue: { _ in })
            .store(in: &cancellable)
        
    }
}
