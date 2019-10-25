//
//  Utility.swift
//  PokeAPIStarter
//
//  Created by K Y on 10/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

extension String {
    var ns: NSString {
        return NSString(string: self)
    }
}

extension Data {
    var ns: NSData {
        return NSData(data: self)
    }
}

extension NSData {
    var data: Data {
        return Data(referencing: self)
    }
}
