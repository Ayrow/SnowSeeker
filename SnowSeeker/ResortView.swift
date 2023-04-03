//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Aymeric Pilaert on 03/04/2023.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 0){
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    Group {
                        Text(resort.description)
                            .padding(.vertical)
                        
                        Text("Facilities")
                            .font(.headline)
                        
                        Text(resort.facilities.joined(separator: ", "))
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("\(resort.name), \(resort.country)")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ResortView(resort: Resort.example)
        }
    }
}
