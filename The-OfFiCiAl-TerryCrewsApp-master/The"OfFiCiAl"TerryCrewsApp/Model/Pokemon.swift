//
//  Pokemon.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/16/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let sprites: Sprites
}

struct Sprites: Decodable {
    let fDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case fDefault = "front_default"
    }
}
