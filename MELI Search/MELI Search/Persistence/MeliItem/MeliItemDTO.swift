//
//  MeliItemDTO.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 20/06/24.
//

import Foundation
import CoreData

extension MeliItemDTO {
    var attributes: Set<ItemAttributesDTO> {
        get {
            attributes_ as? Set<ItemAttributesDTO> ?? []
        }
        set {
            attributes_ = newValue as NSSet
        }
    }
}
