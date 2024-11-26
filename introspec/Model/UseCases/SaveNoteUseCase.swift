//
//  SaveNoteUserCase.swift
//  introspec
//
//  Created by Baba Yaga on 18/11/24.
//

import Foundation
import Combine

protocol SaveNoteUseCase {
    func execute(note: Note) -> AnyPublisher<Void, Error>
}
