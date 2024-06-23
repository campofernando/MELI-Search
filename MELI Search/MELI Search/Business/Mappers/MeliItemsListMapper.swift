//
//  MeliItemsListMapper.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 18/06/24.
//

import Foundation

struct MeliItemsListMapper {
    
    static func map(data: Data?, response: HTTPURLResponse) throws -> [MeliItem] {
        if response.statusCode == 200 {
            guard let data else {
                return []
            }
            let categoryResponse = try JSONDecoder().decode(ItemsResponse.self, from: data)
            return categoryResponse.results
        }
        
        throw(NSError(domain: "Invalid response from API", code: 1120))
    }
}
