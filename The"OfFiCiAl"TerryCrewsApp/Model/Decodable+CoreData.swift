//
//  Decodable+CoreData.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/25/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "NSManagedObjectContext")!
}

enum DecodingError: Error {
    case missingContext
}
