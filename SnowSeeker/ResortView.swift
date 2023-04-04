//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Aymeric Pilaert on 03/04/2023.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    let resort: Resort
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 0){
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    HStack {
                        if sizeClass == .compact && typeSize > .large {
                            VStack(spacing: 10) {ResortDetailsView(resort: resort)}
                            VStack(spacing: 10) {SkiDetailsView(resort: resort)}
                        } else {
                            ResortDetailsView(resort: resort)
                            SkiDetailsView(resort: resort)
                        }
                       
                    }
                    .padding(.vertical)
                    .background(Color.primary.opacity(0.1))
                    .dynamicTypeSize(...DynamicTypeSize.xxLarge)
                    
                    Group {
                        
                        Text(resort.description)
                            .padding(.vertical)
                        
                        Text("Facilities")
                            .font(.headline)
                        
                        HStack {
                            ForEach(resort.facilityTypes) { facility in
                                facility.icon
                                    .font(.title)
                            }
                        }
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
