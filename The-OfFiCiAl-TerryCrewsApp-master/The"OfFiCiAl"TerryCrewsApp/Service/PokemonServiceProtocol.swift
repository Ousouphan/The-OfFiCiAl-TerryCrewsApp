//
//  PokemonServiceProtocol.swift
//  PokeAPIStarter
//
//  Created by K Y on 10/9/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

/*
 Defines the capacities to be owned by any Pokemon Service Adopter.
 
 Remark: we don't return data conventionally as the work is asynchronous by nature
 
 Solution: Add in an extra parameter, a function, that describes what work we will do with it, when completed.
 */

typealias PokeResponse = (Result<Pokemon, PokeDownloadError>) -> Void

protocol PokemonServiceProtocol {
    // 1. a query string
    // 2. some function to perform when downloading completes
    // `completion handler`
    func downloadPokemon(_ query: String, _ completion: @escaping PokeResponse)
    
    // 1. a query Pokemon
    // 2. some function to do when image is done downloading
    func downloadPicture(_ pokemon: Pokemon, _ completion: @escaping (Data?)->Void)
}
