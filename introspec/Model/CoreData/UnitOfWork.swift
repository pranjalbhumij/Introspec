//
//  UnitOfWork.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import Foundation
import CoreData

class UnitOfWork {
    let context: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func commit() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
