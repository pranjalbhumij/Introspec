//
//  NoteEntity+CoreDataProperties.swift
//  introspec
//
//  Created by Baba Yaga on 30/10/24.
//
//

import Foundation
import CoreData


extension NoteEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }
    
    @NSManaged public var content: String?
    @NSManaged public var dateCreation: Date?
    @NSManaged public var dateModified: Date?
    @NSManaged public var id: String
    @NSManaged public var title: String?
    
    func update(with note: Note, context: NSManagedObjectContext) {
        self.content = note.content
        self.dateCreation = note.dateCreation.toDate()
        self.dateModified = note.dateModified.toDate()
        self.id = note.id
        self.title = note.content.toTitle()
    }
    
    func toNote() -> Note {
        return Note(id: self.id,
                    title: self.title!,
                    content: self.content!,
                    dateCreation: self.dateCreation!.toString(),
                    dateModified: self.dateModified!.toString())
    }
    
}

extension NoteEntity : Identifiable {
    
}
