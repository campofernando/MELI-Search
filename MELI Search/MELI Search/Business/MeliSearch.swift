//
//  MeliSearch.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 22/06/24.
//

import Foundation

protocol MeliSearchProtocol {
    func loadDefaultItems(completion: @escaping (Result<[MeliItem], Error>) -> Void)
    func getLastSearches() -> Result<[String], Error>
    func searchItems(withText text: String, completion: @escaping (Result<[MeliItem], Error>) -> Void)
    func getItemDescription(itemId: String, completion: @escaping (Result<String, Error>) -> Void)
}

struct MeliSearch: MeliSearchProtocol {
    let defaultCategoryId = "MLB1367"
    private let apiService: MeliItemsService
    private let dbService: MeliSearchDataService
    
    init(apiService: MeliItemsService, dbService: MeliSearchDataService) {
        self.apiService = apiService
        self.dbService = dbService
    }
    
    func loadDefaultItems(completion: @escaping (Result<[MeliItem], Error>) -> Void) {
        apiService.getItemsByCategory(withCategoryId: defaultCategoryId) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    do {
                        try self.dbService.saveItems(items)
                    } catch {
                        completion(.failure(error))
                    }
                }
                completion(result)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getLastSearches() -> Result<[String], Error> {
        // TODO: Implement functionality for getting last searches made by user
        return .failure(NSError(domain: "Feature not yet implemented", code: -1))
    }
    
    func searchItems(withText text: String, completion: @escaping (Result<[MeliItem], Error>) -> Void) {
        apiService.getItemsBySearch(searchText: text) { result in
            if case .success(let items) = result {
                DispatchQueue.main.async {
                    // TODO: Save last searches in DB once the feature is implemented
                    completion(.success(items))
                }
            }
            completion(result)
        }
    }
    
    func getItemDescription(itemId: String, completion: @escaping (Result<String, Error>) -> Void) {
        apiService.getItemDescription(itemId: itemId) { result in
            switch result {
            case .success(let description):
                completion(.success(description.plainText ?? ""))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
