//
//  MeliSearchMock.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 23/06/24.
//

import Foundation

struct MeliSearchMock: MeliSearchProtocol {
    let itemsResult: Result<[MeliItem], Error>
    let lastSearches: Result<[String], Error>
    
    init(itemsResult: Result<[MeliItem], Error>, lastSearches: Result<[String], Error>) {
        self.itemsResult = itemsResult
        self.lastSearches = lastSearches
    }
    
    func loadDefaultItems(completion: @escaping (Result<[MeliItem], Error>) -> Void) {
        completion(itemsResult)
    }
    
    func getLastSearches() -> Result<[String], Error> {
        return lastSearches
    }
    
    func searchItems(withText text: String, completion: @escaping (Result<[MeliItem], Error>) -> Void) {
        completion(itemsResult)
    }
}
