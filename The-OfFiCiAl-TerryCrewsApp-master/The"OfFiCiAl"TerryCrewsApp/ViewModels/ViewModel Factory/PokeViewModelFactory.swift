//
//  PokeViewModelFactory.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/17/19.
//  Copyright © 2019 K Y. All rights reserved.
//

// Object -> builds VCs
//        -> builds VMs

// Object <- Application Delegate...

import Foundation

class PokeViewModelFactory {
    
    let session = URLSession(configuration: .default)
    let files = ImageFileService()
    let cache = NSCache<NSString, NSData>()
    
    lazy var service: PokemonService = {
       return PokemonService(session, files, cache)
    }()
    
    func buildPokeServiceVM() -> PokemonServiceViewModel {
        let vm = PokemonServiceViewModel(service)
        return vm
    }
    
}
