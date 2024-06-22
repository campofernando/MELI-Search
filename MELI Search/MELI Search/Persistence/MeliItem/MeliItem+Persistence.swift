//
//  MeliItem+Persistence.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 21/06/24.
//

import Foundation
import CoreData

extension MeliItem {
    func managedObject(context: NSManagedObjectContext) -> MeliItemDTO {
        let managedObject = MeliItemDTO(context: context)
        managedObject.itemId = itemId
        return managedObject
    }
}
