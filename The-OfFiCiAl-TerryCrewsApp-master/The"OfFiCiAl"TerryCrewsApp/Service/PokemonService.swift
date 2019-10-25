//
//  PokemonService.swift
//  PokeAPIStarter
//
//  Created by K Y on 10/9/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

/*
 ## download a Pokemon
 1. Make a DataTask, download for the query
 2. Transform the Data -> Dictionary
 3. Crawl through Dictionary to get our strings
 */

// Closures are also known as/similar to:
// Blocks
// Lambda Functions
// Anonymous Functions

final class PokemonService: PokemonServiceProtocol {
    
    let session: URLSession
    let files: ImageFileService
    let cache: NSCache<NSString, NSData>
    
    init(_ session: URLSession,
         _ files: ImageFileService,
         _ cache: NSCache<NSString, NSData>) {
        self.session = session
        self.files = files
        self.cache = cache
    }
    
    func downloadPokemon(_ query: String,
                         _ completion: @escaping PokeResponse) {
        
        // cover edge-cases where multiple downloads are required
        if query.lowercased() == "nidoran" {
            downloadPokemonHelper("nidoran-m", completion)
            downloadPokemonHelper("nidoran-f", completion)
        }
        else {
            downloadPokemonHelper(query, completion)
        }
    }
    
    func downloadPokemonHelper(_ query: String,
                               _ completion: @escaping PokeResponse) {
        // validate the query
        guard let url = PokemonValidator.validate(query) else {
            completion(.failure(.badSearchQuery))
            return
        }
        downloadPokemon(url, completion)
    }
    
    func downloadPokemon(_ url: URL, _ completion: @escaping PokeResponse) {
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let err = error {
                completion(.failure(.networkError(err)))
                return
            }
            if let response = response, let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                    case 400..<500:
                        completion(.failure(.missingPage))
                        return
                    case 500..<600:
                        completion(.failure(.serverError))
                        return
                    default:
                        break
                }
            }
            guard let data = data else {
                completion(.failure(.emptyResponse))
                return
            }
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            }
            catch {
                completion(.failure(.badSearchQuery))
            }
        }
        dataTask.resume()
    }
    
    /*
     Image Downloading:
     
     Use image from memory first!
     Use image from disk second!
     If we have never saved nor used the image, download it from the web.
     
     Benefit: faster, reduce network access
     (But requires some complexity)
     
     */
    
    func downloadPicture(_ pokemon: Pokemon, _ completion: @escaping (Data?)->()) {
        guard let urlString = pokemon.sprites.fDefault else {
            completion(nil)
            return
        }
        let fileName = URL(string: urlString)!
            .relativePath
            .components(separatedBy: "/")
            .last!
        
        // 1. is this image already in an in-memory cache?
        // RAM
        // YES: return that.
        if let image = cache.object(forKey: fileName.ns) {
            print("Did load from in-memory")
            completion(image.data)
            return
        }
        
        // 2. is this image already in our local filesystem?
        // Disk
        // YES: return that
        if let image = files.load(name: fileName) {
            // also adds to the in-memory cache
            print("Did load from filesystem")
            cache.setObject(image.ns, forKey: fileName.ns)
            completion(image)
            return
        }
        
        // 3. download it from the network
        let url = URL(string: urlString)!
        let dataTask = session.dataTask(with: url) { (data, _, _) in
            // also add to in-memory cache
            // also adds to filesystem
            if let image = data {
                print("Did load from internet")
                self.cache.setObject(image.ns, forKey: fileName.ns)
                self.files.save(name: fileName, image)
            }
            completion(data)
        }
        dataTask.resume()
    }

}
