//
//  CoreDataNoteRepository.swift
//  introspec
//
//  Created by Baba Yaga on 18/11/24.
//

import Foundation
import CoreData
import Combine

class CoreDataNoteRepository: NoteRepository {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchNotes() -> AnyPublisher<[Note], Error> {
        Future { [weak self] promise in
            let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
            promise(Result {
                let results = try self!.context.fetch(request)
                return results.map { $0.toNote() }
            })
        }
        .eraseToAnyPublisher()
    }
    
    func save(note: Note) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            let noteEntity = NoteEntity(context: self!.context)
            noteEntity.update(with: note, context: self!.context)
            promise(Result { try self!.saveContext() })
        }
        .eraseToAnyPublisher()
    }
    
    func update(note: Note) -> AnyPublisher<Void, Error>  {
        Future { [weak self] promise in
            let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", note.id)
            promise(Result {
                if let noteEntity = try self!.context.fetch(fetchRequest).first {
                    noteEntity.update(with: note, context: self!.context)
                    try self!.saveContext()
                }
            })
        }
        .eraseToAnyPublisher()
    }
    
    func delete(id: String) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            promise(Result {
                if let noteEntity = try self!.context.fetch(fetchRequest).first {
                    self!.context.delete(noteEntity)
                    try self!.saveContext()
                    promise(.success(()))
                }
            })
        }
        .eraseToAnyPublisher()
    }
    
    func search(predicate: String) -> AnyPublisher<[Note], any Error> {
        Future { [weak self] promise in
            promise(Result {
                let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "content CONTAINS[cd] %@", predicate)
                let results = try self!.context.fetch(fetchRequest)
                return results.map { $0.toNote() }
            })
        }
        .eraseToAnyPublisher()
    }
        
    private func saveContext() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
