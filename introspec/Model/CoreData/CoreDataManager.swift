//
//  CoreDataManager.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import CoreData

public class CoreDataManager {
    public static func shared(containerName: String, dbPath: URL) -> CoreDataManager{
        return CoreDataManager(containerName: containerName, dbPath: dbPath)
    }
    
    private let containerName: String
    private let dbPath: URL
    
    private init(containerName: String, dbPath: URL) {
        self.containerName = containerName
        self.dbPath = dbPath
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let bundle = Bundle.main
        let modelName = self.containerName
        guard let modelURL = bundle.url(forResource: modelName, withExtension: "momd") else {
            fatalError("Failed to load store: Model not found in main bundle.")
        }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to load store: Could not create NSManagedObjectModel.")
        }
        let container = NSPersistentContainer(name: modelName, managedObjectModel: model)
        let description = NSPersistentStoreDescription()
        description.url = dbPath
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load store: \(error)")
            }
        }
        return container
    }()
    
    public var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
