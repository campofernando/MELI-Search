//
//  MeliItem+Mock.swift
//  MELI SearchTests
//
//  Created by Fernando Campo Garcia on 21/06/24.
//

import Foundation

extension MeliItem {
    static func getMocks() throws -> [MeliItem] {
        guard let url = Bundle.main.url(forResource: "MeliItemMock", withExtension: "json") else {
            throw NSError(domain: "MeliItemMock file not found", code: 1121)
        }
        let jsonData = try Data(contentsOf: url)
        let items = try JSONDecoder().decode(ItemsResponse.self, from: jsonData)
        return items.results
    }
    
    func getMock(withId id: String?) -> MeliItem {
        return MeliItem(
            itemId: id,
            title: title,
            categoryId: categoryId,
            permalink: permalink,
            thumbnail: thumbnail,
            currencyId: currencyId,
            price: price,
            availableQuantity: availableQuantity,
            acceptsMercadopago: acceptsMercadopago,
            shipping: shipping,
            attributes: attributes,
            installments: installments
        )
    }
}
