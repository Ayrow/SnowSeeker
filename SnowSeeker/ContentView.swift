//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Aymeric Pilaert on 01/04/2023.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    @StateObject var favorites = Favorites()
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        
        NavigationView {
            List(viewModel.sortedAndFilteredResults) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                   
                    if favorites.contains(resort){
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                            .foregroundColor(.red)
                    }
                }
                    
                }
            }
            .animation(Animation.default, value: viewModel.sortedAndFilteredResults)
            .navigationTitle("Resorts")
            .searchable(text: $viewModel.searchText, prompt: "Search for a resort")
            .toolbar {
                Button("Sort"){
                    viewModel.showSortingDialog.toggle()
                }
            }
            .confirmationDialog("Sort resorts", isPresented: $viewModel.showSortingDialog) {
                Button("By name"){
                    viewModel.sorting = .byName
                }
                Button("By country"){
                    viewModel.sorting = .byCountry
                }
                Button("Default"){
                    viewModel.sorting = nil
                }
            } message: {
                Text("Sort the resorts")
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
    
    
    
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
