//
//  Pokemon+CoreDataClass.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/25/19.
//  Copyright © 2019 K Y. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Pokemon)
public class Pokemon: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case sprites
    }
    public required convenience init(from decoder: Decoder) throws {
        let userInfo = decoder.userInfo
        guard let context = userInfo[.context] as? NSManagedObjectContext else {
            throw DecodingError.missingContext
        }
        let desc = NSEntityDescription.entity(forEntityName: "Pokemon",
                                              in: context)!
        self.init(entity: desc, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        sprites = try container.decode(Sprites.self, forKey: .sprites)
    }
}
