//
//  MeliBRApiHelper.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 17/06/24.
//

import Foundation

enum MeliBRApiHelper {
    static let domain: String = "https://api.mercadolibre.com/"
    static let site: String = "sites/MLB/"
    
    static func getCategorySearchPath(withCategoryId id: String) -> String {
        return "search?category=\(id)"
    }
    
    static func getCategorySearchURL(withCategoryId id: String) -> URL? {
        let searchCategoryPath = domain + site + getCategorySearchPath(withCategoryId: id)
        return URL(string: searchCategoryPath)
    }
    
    static func getItemsSearchPath(withText text: String) -> String {
        return "search?q=\(text)"
    }
    
    static func getItemsSearchURL(withText text: String) -> URL? {
        let searchItemsPath = domain + site + getItemsSearchPath(withText: text)
        guard let searchItemsURLString = searchItemsPath
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        return URL(string: searchItemsURLString)
    }
    
    static func getItemDescriptionPath(itemId: String) -> String {
        return "items/\(itemId)/description"
    }
    
    static func getItemDescriptionURL(itemId: String) -> URL? {
        let path = domain + getItemDescriptionPath(itemId: itemId)
        return URL(string: path)
    }
}
