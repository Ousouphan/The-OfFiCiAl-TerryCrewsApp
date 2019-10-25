//
//  PokemonValidator.swift
//  PokeAPIStarter
//
//  Created by K Y on 10/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

private let quotes = Set("'’\"")

struct PokemonValidator {
    
    static func validate(_ query: String) -> URL? {
        
        // empty query case?
        if query.isEmpty {
            return nil
        }
        // special cases:
        /*
         1. type: null -> type-null -> Type: Null
         2. mr. mime
         3. nidoran-m "nidoran male"
            nidoran-f
         4. farfetchd - farfetch'd
         */
        
        // 1.
        // go through each letter, building words
        // (a word ends when I find a non-character)
        // add each word into an array
        // at the end: i have an array of words
        // 2.
        // combine the array of words into a string
        // with - as a separator
        let noApQuery = query.filter { quotes.contains($0) == false }
        let words = noApQuery.components(separatedBy: CharacterSet.alphanumerics.inverted)
        let nonEmptyWords = words.filter { $0.isEmpty == false }
        let newQuery = nonEmptyWords.joined(separator: "-").lowercased()
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(newQuery)") else {
            return nil
        }
        
        return url
        
    }
    
}
