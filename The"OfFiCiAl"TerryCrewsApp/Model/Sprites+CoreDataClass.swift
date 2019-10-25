//
//  Sprites+CoreDataClass.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/25/19.
//  Copyright © 2019 K Y. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Sprites)
public class Sprites: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case fDefault = "front_default"
    }
    
    public required init(from decoder: Decoder) throws {
        let userInfo = decoder.userInfo
        guard let context = userInfo[.context] as? NSManagedObjectContext else {
            throw DecodingError.missingContext
        }
        let desc = NSEntityDescription.entity(forEntityName: "Sprites",
                                              in: context)!
        super.init(entity: desc, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fDefault = try container.decode(String.self, forKey: .fDefault)
    }
}
