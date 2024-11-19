//
//  FetchNotesUseCase.swift
//  introspec
//
//  Created by Baba Yaga on 18/11/24.
//

import Foundation

protocol FetchNotesUseCase {
    func execute() -> [Note]
}
