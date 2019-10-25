//
//  Pokemon+CoreDataProperties.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/25/19.
//  Copyright © 2019 K Y. All rights reserved.
//
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon")
    }

    @NSManaged public var name: String
    @NSManaged public var sprites: Sprites
    @NSManaged public var trainer: Trainer?

}
