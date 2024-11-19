//
//  CoreDataNoteRepository.swift
//  introspec
//
//  Created by Baba Yaga on 18/11/24.
//

import Foundation
import CoreData

class CoreDataNoteRepository: NoteRepository {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchNotes() -> [Note] {
        let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        do {
            let results = try context.fetch(request)
            return results.map { $0.toNote() }
        } catch {
            print("Error fetching notes: \(error)")
            return []
        }
    }
    
    func save(note: Note) {
        let noteEntity = NoteEntity(context: context)
        noteEntity.update(with: note, context: context)
        saveContext()
    }
    
    func update(note: Note) {
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", note.id)
        do {
            if let noteEntity = try context.fetch(fetchRequest).first {
                noteEntity.update(with: note, context: context)
                saveContext()
            }
        } catch {
            print("Error updating note: \(error)")
        }
    }
    
    func delete(id: String) {
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            if let noteEntity = try context.fetch(fetchRequest).first {
                context.delete(noteEntity)
                saveContext()
            }
        } catch {
            print("Error deleting note: \(error)")
        }
    }
        
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}
