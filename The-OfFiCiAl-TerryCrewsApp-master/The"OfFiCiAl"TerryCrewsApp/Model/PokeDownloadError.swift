//
//  PokeDownloadError.swift
//  PokeAPIStarter
//
//  Created by K Y on 10/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

// Lists all cases of different error behaviors possible

enum PokeDownloadError: Error {
    case networkError(Error)
    case emptyResponse
    case missingPage
    case serverError
    case missingImage
    case missingName
    case badSearchQuery
}

/*
enum Result<T, Error> {
    case success(T)
    case failure(Error)
}

enum Optional<T> {
    case some(T)
    case none // nil
}
*/
