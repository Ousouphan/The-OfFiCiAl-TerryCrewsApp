//
//  PokemonServiceViewModel.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/16/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

class PokemonServiceViewModel: PokemonServiceViewModelProtocol {
    
    var pokemon = [Pokemon]()
    var count: Int {
        return pokemon.count
    }
    var handler: (()->Void)?
    
    let service = PokemonService.shared
    
    func bind(_ handler: @escaping () -> Void) {
        self.handler = handler
    }
    
    func download(_ query: String) {
        service.downloadPokemon(query) { (result) in
            switch result {
            case .success(let poke):
                self.pokemon.append(poke)
                self.handler?()
            default:
                print("Error")
            }
        }
    }
    
    func image(at index: Int, _ completion: @escaping (Data?) -> Void) {
        let mon = pokemon[index]
        service.downloadPicture(mon) { (dat) in
            completion(dat)
        }
    }
    
    func pokemon(at index: Int) -> Pokemon {
        return pokemon[index]
    }
    
    func caught(at index: Int) {
        print("did catch \(pokemon[index].name)")
    }
    
}
