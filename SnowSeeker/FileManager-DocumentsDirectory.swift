//
//  FileManager-DocumentsDirectory.swift
//  SnowSeeker
//
//  Created by Aymeric Pilaert on 04/04/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
