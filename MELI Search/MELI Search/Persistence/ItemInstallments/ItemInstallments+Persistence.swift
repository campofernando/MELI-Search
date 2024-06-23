//
//  ItemInstallments+Persistence.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 21/06/24.
//

import Foundation
import CoreData

extension ItemInstallments {
    init(managedObject: ItemInstallmentsDTO) {
        self.quantity = UInt(managedObject.quantity)
        self.amount = managedObject.amount
        self.rate = managedObject.rate
        self.currencyId = managedObject.currencyId
    }
    
    func managedObject(context: NSManagedObjectContext) -> ItemInstallmentsDTO {
        let managedObject = ItemInstallmentsDTO(context: context)
        if let quantity {
            managedObject.quantity = Int64(quantity)
        }
        if let amount {
            managedObject.amount = amount
        }
        if let rate {
            managedObject.rate = rate
        }
        if let currencyId {
            managedObject.currencyId = currencyId
        }
        return managedObject
    }
}
