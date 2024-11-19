//
//  PathFactory.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import Foundation

struct PathFactory {
    
    static func getDBPath(dbName: String) -> URL {
        return FileManager.default.temporaryDirectory.appendingPathComponent(dbName)
    }
}
