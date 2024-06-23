//
//  MeliItemDescription.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 23/06/24.
//

struct Snapshot: Codable {
    let url: String
}

struct MeliItemDescription: Codable {
    let text: String?
    let plainText: String?
    let snapshot: Snapshot?
    
    enum CodingKeys: String, CodingKey {
        case text
        case plainText = "plain_text"
        case snapshot
    }
}
