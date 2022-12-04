//
//  PokemonMO+CoreDataProperties.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 4.12.22.
//
//

import Foundation
import CoreData


extension PokemonMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonMO> {
        return NSFetchRequest<PokemonMO>(entityName: "PokemonMO")
    }

    @NSManaged public var frontDefault: Data?
    @NSManaged public var height: Int32
    @NSManaged public var homeFrontDefault: Data?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var offArtFrontDefault: Data?
    @NSManaged public var types: Data?
    @NSManaged public var weight: Int32

}

extension PokemonMO : Identifiable {}
