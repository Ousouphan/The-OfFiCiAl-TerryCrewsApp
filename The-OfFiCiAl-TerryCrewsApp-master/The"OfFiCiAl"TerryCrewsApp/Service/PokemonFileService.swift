//
//  ImageFileService.swift
//  W2D1TableApp
//
//  Created by K Y on 10/8/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

class ImageFileService {
    
    let fileManager: FileManager
    let directory: URL
    
    init() {
        fileManager = FileManager.default
        directory = fileManager.urls(for: .cachesDirectory,
                                     in: .userDomainMask).first!
    }
    
    // BinaryData -> Saved to Disk
    func save(name: String, _ image: Data) {
        do {
            let file = directory.appendingPathComponent(name)
            try image.write(to: file)
        }
        catch {
            print("save-stop")
            //print("Error found!: \(error)")
        }
    }
    
    // Read from Disk -> BinaryData
    func load(name: String) -> Data? {
        do {
            let file = directory.appendingPathComponent(name)
            let image: Data = try Data(contentsOf: file)
            return image
        }
        catch {
            print("load-stop")
            //print("Error loading file! :\(error)")
        }
        return nil
    }
    
}
