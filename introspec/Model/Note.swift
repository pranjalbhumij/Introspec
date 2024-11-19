//
//  Note.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import Foundation

struct Note: Decodable, Identifiable, Hashable {
    var id: String
    var title: String
    var content: String
    var dateCreation: String
    var dateModified: String
}
