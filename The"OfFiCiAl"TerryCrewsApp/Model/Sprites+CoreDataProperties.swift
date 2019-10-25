//
//  Sprites+CoreDataProperties.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/25/19.
//  Copyright © 2019 K Y. All rights reserved.
//
//

import Foundation
import CoreData


extension Sprites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sprites> {
        return NSFetchRequest<Sprites>(entityName: "Sprites")
    }

    @NSManaged public var fDefault: String?
    @NSManaged public var pokemon: Pokemon?

}
