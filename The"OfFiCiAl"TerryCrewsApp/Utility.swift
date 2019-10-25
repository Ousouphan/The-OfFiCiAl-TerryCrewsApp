//
//  Utility.swift
//  PokeAPIStarter
//
//  Created by K Y on 10/10/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

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

extension UIView {
    func setupToFill(superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}
