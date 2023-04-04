//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Aymeric Pilaert on 04/04/2023.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    
    private let savedPath = FileManager.documentsDirectory.appendingPathComponent("Favorites")
    
    init() {
        do {
            let data = try Data(contentsOf: savedPath)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort){
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort){
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save(){
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: savedPath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save the favorites")
        }
    }
        
 }
