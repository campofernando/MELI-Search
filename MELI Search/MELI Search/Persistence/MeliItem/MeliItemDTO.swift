//
//  MeliItemDTO.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 20/06/24.
//

import Foundation
import CoreData

extension MeliItemDTO {
    static let entityName = "MeliItemDTO"
    
    var attributes: Set<ItemAttributesDTO> {
        get {
            attributes_ as? Set<ItemAttributesDTO> ?? []
        }
        set {
            attributes_ = newValue as NSSet
        }
    }
    
    static func fetchRequestItems(ofCategory category: String) -> NSFetchRequest<MeliItemDTO> {
        let request = NSFetchRequest<MeliItemDTO>(entityName: "MeliItemDTO")
        request.sortDescriptors = [NSSortDescriptor(key: "price", ascending: true)]
        let predicate = NSPredicate(format: "categoryId = %@", category)
        request.predicate = predicate
        return request
    }
}

extension MeliItem {
    init(managedObject: MeliItemDTO) {
        self.itemId = managedObject.itemId
        self.title = managedObject.title
        self.categoryId = managedObject.categoryId
        self.permalink = managedObject.permalink
        self.thumbnail = managedObject.thumbnail
        self.currencyId = managedObject.currencyId
        self.price = managedObject.price
        self.availableQuantity = UInt(managedObject.availableQuantity)
        self.acceptsMercadopago = managedObject.acceptsMercadopago
        if let shippingObect = managedObject.shipping {
            self.shipping = ShippingDetails(managedObject: shippingObect)
        } else {
            self.shipping = nil
        }
        if let installmentsObject = managedObject.installments {
            self.installments = ItemInstallments(managedObject: installmentsObject)
        } else {
            self.installments = nil
        }
        self.attributes = managedObject.attributes.compactMap { ItemAttributes(managedObject: $0) }
    }
    
    func managedObject(context: NSManagedObjectContext) -> MeliItemDTO {
        let managedObject = MeliItemDTO(context: context)
        managedObject.itemId = itemId
        return managedObject
    }
}
