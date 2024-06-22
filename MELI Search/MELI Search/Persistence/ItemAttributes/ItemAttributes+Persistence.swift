//
//  ItemAttributes+Persistence.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 21/06/24.
//

import Foundation
import CoreData

extension ItemAttributes {
    func managedObject(context: NSManagedObjectContext) -> ItemAttributesDTO {
        let managedObject = ItemAttributesDTO(context: context)
        managedObject.attributeId = self.attributeId
        managedObject.attributeName = self.attributeName
        managedObject.attributeValue = self.attributeValue
        return managedObject
    }
}

