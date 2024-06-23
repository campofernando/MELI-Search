//
//  ItemAttributes+Persistence.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 21/06/24.
//

import Foundation
import CoreData

extension ItemAttributes {
    init(managedObject: ItemAttributesDTO) {
        self.attributeId = managedObject.attributeId
        self.attributeName = managedObject.attributeName
        self.attributeValue = managedObject.attributeValue
    }
    
    func managedObject(context: NSManagedObjectContext) -> ItemAttributesDTO {
        let managedObject = ItemAttributesDTO(context: context)
        managedObject.attributeId = self.attributeId
        managedObject.attributeName = self.attributeName
        managedObject.attributeValue = self.attributeValue
        return managedObject
    }
}

