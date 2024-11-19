//
//  NoteRepository.swift
//  introspec
//
//  Created by Baba Yaga on 18/11/24.
//

import Foundation

protocol NoteRepository {
    func fetchNotes() -> [Note]
    func save(note: Note)
    func update(note: Note)
    func delete(id: String)
}
