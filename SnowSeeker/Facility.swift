//
//  Facility.swift
//  SnowSeeker
//
//  Created by Aymeric Pilaert on 04/04/2023.
//

import SwiftUI

struct Facility: Identifiable {
    let id = UUID()
    var name: String
    
    private let icons = [
        "Accomodation" : "house",
        "Beginners" : "1.circle",
        "Cross-country" : "map",
        "Eco-friendly" : "leaf.arrow.circlepath",
        "Family" : "person.3"
    ]
    
    var icon: some View {
        if let iconName = icons[name] {
            return Image(systemName: iconName)
                .accessibilityLabel(name)
                .foregroundColor(.secondary)
        } else {
            fatalError("Unknown facility type: \(name)")
        }
    }
}
