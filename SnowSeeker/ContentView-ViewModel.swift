//
//  ContentView-ViewModel.swift
//  SnowSeeker
//
//  Created by Aymeric Pilaert on 04/04/2023.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        private let resorts: [Resort] = Bundle.main.decode("resorts.json")
        @Published var searchText = ""
        @Published var sorting: sortedBy?
        @Published var showSortingDialog = false
        
        var filteredResorts: [Resort] {
            if searchText.isEmpty {
                return resorts
            } else {
                return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
            }
        }
        
        enum sortedBy {
            case byName, byCountry
        }
        
        var sortedAndFilteredResults: [Resort] {
            switch sorting {
            case .byName:
                return filteredResorts.sorted { lhs, rhs in
                    lhs.name < rhs.name
                }
            case .byCountry:
                return filteredResorts.sorted { lhs, rhs in
                    lhs.country < rhs.country
                }
            default:
                return filteredResorts
            }
        }
        
    }
}
