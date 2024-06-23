//
//  MELISearchDataService.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 20/06/24.
//

import Foundation
import CoreData

struct MeliSearchDataService {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveItems(_ items: [MeliItem]) throws {
        for item in items {
            try saveItem(item)
        }
    }
    
    func saveItem(_ item: MeliItem) throws {
        if let currentItem = try fetchItem(withId: item.itemId) {
            try update(currentItem: currentItem, withItem: item)
            return
        }
        let itemObject = item.managedObject(context: context)
        try update(currentItem: itemObject, withItem: item)
    }
    
    func fetchItem(withId itemId: String?) throws -> MeliItemDTO? {
        guard let itemId else {
            return nil
        }
        let request = NSFetchRequest<MeliItemDTO>(entityName: MeliItemDTO.entityName)
        request.predicate = NSPredicate(format: "itemId = %@", itemId)
        return try context.fetch(request).first
    }
    
    func fetchItems() throws -> [MeliItemDTO] {
        let request = NSFetchRequest<MeliItemDTO>(entityName: MeliItemDTO.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "price", ascending: true)]
        return try context.fetch(request)
    }
    
    func fetchItems(ofCategory category: String) throws -> [MeliItemDTO] {
        let request = NSFetchRequest<MeliItemDTO>(entityName: MeliItemDTO.entityName)
        request.predicate = NSPredicate(format: "categoryId = %@", category)
        return try context.fetch(request)
    }
    
    private func update(currentItem: MeliItemDTO, withItem item: MeliItem) throws {
        currentItem.itemId = item.itemId
        currentItem.title = item.title
        currentItem.permalink = item.permalink
        currentItem.thumbnail = item.thumbnail
        currentItem.currencyId = item.currencyId
        if let price = item.price {
            currentItem.price = price
        }
        if let availableQuantity = item.availableQuantity {
            currentItem.availableQuantity = Int64(availableQuantity)
        }
        currentItem.acceptsMercadopago = item.acceptsMercadopago ?? false
        currentItem.shipping = item.shipping?.managedObject(context: context)
        currentItem.attributes = Set(item.attributes.compactMap { $0.managedObject(context: context) })
        currentItem.installments = item.installments?.managedObject(context: context)
        currentItem.objectWillChange.send()
        currentItem.shipping?.objectWillChange.send()
        currentItem.attributes.forEach { $0.objectWillChange.send() }
        currentItem.installments?.objectWillChange.send()
        try context.save()
    }
}
