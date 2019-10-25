//
//  PokemonServiceViewModelProtocol.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/16/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

// will be used for Pokemon catch & download screen
// wherein we download several pokemon, show them to the user
// allow them to catch them.

protocol PokemonServiceViewModelProtocol {
    
    var count: Int { get }
    
    func bind(_ handler: @escaping ()->Void)
    func download(_ query: String) 
    func image(at index: Int, _ completion: @escaping (Data?)->Void)
    
    // go to a catch screen, somehow
    func pokemon(at index: Int) -> Pokemon
    
    // we caught a pokemon
    func caught(at index: Int)
}
