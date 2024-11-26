//
//  DeleteNoteUseCase.swift
//  introspec
//
//  Created by Baba Yaga on 18/11/24.
//

import Foundation
import Combine

protocol DeleteNoteUseCase {
    func execute(id: String) -> AnyPublisher<Void, Error>
}
