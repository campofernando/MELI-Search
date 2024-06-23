//
//  MeliIemDescriptionMapper.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 23/06/24.
//

import Foundation

struct MeliIemDescriptionMapper {
    
    static func map(data: Data?, response: HTTPURLResponse) throws -> MeliItemDescription {
        if response.statusCode == 200 {
            guard let data else {
                throw(NSError(domain: "Invalid data", code: 1121))
            }
            let description = try JSONDecoder().decode(MeliItemDescription.self, from: data)
            return description
        }
        
        throw(NSError(domain: "Invalid response from API", code: 1120))
    }
}
