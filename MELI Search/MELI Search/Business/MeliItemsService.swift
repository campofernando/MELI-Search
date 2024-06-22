//
//  MELItemsService.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 17/06/24.
//

import Foundation

struct MeliItemsService {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func getItemsByCategory(withCategoryId categoryId: String, completion: @escaping (Result<[MelItem], Error>) -> Void) {
        guard let url = MeliBRApiHelper.getCategorySearchURL(withCategoryId: categoryId) else {
            completion(.failure(URLSession.InvalidURLRequestError()))
            return
        }
        performRequest(url: url, completion: completion)
    }
    
    func getItemsBySearch(searchText: String, completion: @escaping (Result<[MelItem], Error>) -> Void) {
        guard let url = MeliBRApiHelper.getItemsSearchURL(withText: searchText) else {
            completion(.failure(URLSession.InvalidURLRequestError()))
            return
        }
        performRequest(url: url, completion: completion)
    }
    
    private func performRequest(url: URL, completion: @escaping (Result<[MelItem], Error>) -> Void) {
        let request = URLRequest(url: url)
        httpClient.performRequest(request: request) { result in
            switch result {
            case .success(let success):
                do {
                    let items = try MeliItemsListMapper.map(data: success.data, response: success.httpResponse)
                    completion(.success(items))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
