//
//  NewMockDataService.swift
//  UnitTestApp
//
//  Created by Zuber Rehmani on 02/04/24.
//

import Foundation
import SwiftUI
import Combine

protocol NewDataServiceProtocol {
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> ())
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

class NewMockDataService: NewDataServiceProtocol {
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? ["One", "Two", "Three"]
    }
    
    func downloadItemsWithEscaping(completion: @escaping ([String]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            completion(self?.items ?? [])
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap({ publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedItems
            })
            .eraseToAnyPublisher()
    }
}   
