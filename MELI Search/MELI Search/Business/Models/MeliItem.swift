//
//  MeliItem.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 18/06/24.
//

import Foundation

struct ShippingDetails: Codable {
    let storePickUp: Bool?
    let freeShipping: Bool?
    
    enum CodingKeys: String, CodingKey {
        case storePickUp = "store_pick_up"
        case freeShipping = "free_shipping"
    }
}

struct ItemAttributes: Codable {
    let attributeId: String?
    let attributeName: String?
    let attributeValue: String?
    
    enum CodingKeys: String, CodingKey {
        case attributeId = "id"
        case attributeName = "name"
        case attributeValue = "value_name"
    }
}

struct ItemInstallments: Codable {
    let quantity: UInt?
    let amount: Float?
    let rate: Float?
    let currencyId: String?
    
    enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyId = "currency_id"
    }
}

struct MelItem: Codable {
    let itemId: String?
    let title: String?
    let permalink: String?
    let thumbnail: String?
    let currencyId: String?
    let price: Float?
    let availableQuantity: UInt?
    let acceptsMercadopago: Bool?
    let shipping: ShippingDetails?
    let attributes: [ItemAttributes]
    let installments: ItemInstallments?
    
    enum CodingKeys: String, CodingKey {
        case itemId = "id"
        case title, permalink, thumbnail
        case currencyId = "currency_id"
        case price
        case availableQuantity = "available_quantity"
        case acceptsMercadopago = "accepts_mercadopago"
        case shipping, attributes, installments
    }
}

struct ItemsResponse: Codable {
    let results: [MelItem]
}
