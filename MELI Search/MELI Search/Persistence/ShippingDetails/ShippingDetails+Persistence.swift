//
//  ShippingDetails+Persistence.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 21/06/24.
//

import Foundation
import CoreData

extension ShippingDetails {
    func managedObject(context: NSManagedObjectContext) -> ShippingDetailsDTO {
        let managedObject = ShippingDetailsDTO(context: context)
        managedObject.storePickUp = self.storePickUp ?? false
        managedObject.freeShipping = self.freeShipping ?? false
        return managedObject
    }
}
