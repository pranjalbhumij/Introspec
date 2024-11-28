//
//  NoteRepository.swift
//  introspec
//
//  Created by Baba Yaga on 18/11/24.
//

import Foundation
import Combine

protocol NoteRepository {
    func fetchNotes() -> AnyPublisher<[Note], Error>
    func save(note: Note) -> AnyPublisher<Void, Error>
    func update(note: Note) -> AnyPublisher<Void, Error>
    func delete(id: String) -> AnyPublisher<Void, Error>
    func search(predicate: String) -> AnyPublisher<[Note], Error>
}
