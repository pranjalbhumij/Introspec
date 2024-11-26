//
//  FetchNotesUseCase.swift
//  introspec
//
//  Created by Baba Yaga on 18/11/24.
//

import Foundation
import Combine

protocol FetchNotesUseCase {
    func execute() -> AnyPublisher<[Note],Error>
}
