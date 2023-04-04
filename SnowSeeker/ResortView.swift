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
    @EnvironmentObject var favorites: Favorites
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    
    
    let resort: Resort
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 0){
                    ZStack(alignment: .bottomTrailing) {
                        Image(decorative: resort.id)
                            .resizable()
                        .scaledToFit()
                        
                        Text("Credits: \(resort.imageCredit)")
                            .font(.caption)
                            .padding(.horizontal)
                            .padding(.bottom, 5)
                            .background(.white.opacity(0.6))
                    }
                    
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
                                Button {
                                    selectedFacility = facility
                                    showingFacility = true
                                } label: {
                                    facility.icon
                                        .font(.title)
                                }
                                
                            }
                        }
                        
                        Button(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites") {
                            if favorites.contains(resort) {
                                favorites.remove(resort)
                            } else {
                                favorites.add(resort)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("\(resort.name), \(resort.country)")
            .navigationBarTitleDisplayMode(.inline)
            .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility){_ in
            } message: { facility in
                Text(facility.description)
            }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ResortView(resort: Resort.example)
        }
        .environmentObject(Favorites())
    }
}
