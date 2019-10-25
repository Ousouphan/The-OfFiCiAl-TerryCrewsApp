//
//  PokemonServiceViewModel.swift
//  The"OfFiCiAl"TerryCrewsApp
//
//  Created by K Y on 10/16/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

class PokemonServiceViewModel: PokemonServiceViewModelProtocol {
    
    // MARK: - Properties
    
    var pokemon = [Pokemon]() {
        didSet {
            handler?()
        }
    }
    var count: Int {
        return pokemon.count
    }
    var handler: (()->Void)?
    var trainer: Trainer? {
        didSet {
            guard let t = trainer else { return }
            print("Did load trainer \(t.name!), who has \(t.pokemon?.count ?? 0) captured!")
        }
    }
    
    let service: PokemonServiceProtocol
    let downloadLock = NSLock()
    
    // MARK: - Initializers
    
    init(_ service: PokemonServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Data-binding Method
    
    func bind(_ handler: @escaping () -> Void) {
        self.handler = handler
    }
    
    // MARK: - Networking Functions
    
    func download(_ query: String) {
        service.downloadPokemon(query) { (result) in
            switch result {
            case .success(let poke):
                self.pokemon.append(poke)
            default:
                print("Error")
            }
        }
    }
    
    func batchDownload(_ queries: [String]) {
        downloadLock.lock()
        // 1. have a container/array for all downloads
        let group = DispatchGroup()
        // 2. for each download, when done, put it in its proper location
        //    within the container
        var newPokemon: [Pokemon?] = Array<Pokemon?>(repeating: nil,
                                                     count: queries.count)
        for (i, q) in queries.enumerated() {
            group.enter()
            service.downloadPokemon(q) { (result) in
                switch result {
                case .success(let poke):
                    newPokemon[i] = poke
                default:
                    print("Error")
                }
                group.leave()
            }
        }
        // 3. when all downloads are done, then append to the pokemon array
        //    this will update my binders & ui.
        group.notify(queue: .global()) {
            let nonNilPokemon = newPokemon.compactMap { $0 }
            self.pokemon.append(contentsOf: nonNilPokemon)
            self.downloadLock.unlock()
        }
    }
    
    // MARK: - Data Accessors
    
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
        let mon = pokemon[index]
        print("did catch \(mon.name)")
        trainer?.addToPokemon(mon)
        pokemon.remove(at: index)
        service.saveData()
    }
    
    func makeTrainer(name: String, image: Data) {
        // make trainer here with service
        trainer = service.makeTrainer(name: name, image: image)
        service.saveData()
    }
    
}
