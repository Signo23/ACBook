//
//  CatalogueView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct CatalogView: View {
    var viewModel: DataLoader = DataLoader()

    var body: some View {
        NavigationView{
            List(){
                Section(header: Text("")){
                    NavigationLink(destination: MuseumView(viewModel: viewModel)){
                        Label("Museum", systemImage: "building.columns.fill")

                    }
                }
                Section(){
                    NavigationLink(destination: CatalogableListView(viewModel: viewModel, type: .villagers)){
                        Label("Villagers", systemImage: "hare.fill")
                    }
                }
                
                CatalogableMenuView(viewModel: viewModel)
                
            }.navigationTitle("Catalog")
            .listStyle(InsetGroupedListStyle())
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
