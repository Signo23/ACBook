//
//  CatalogueView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct CatalogView: View {
    var viewModel: DataLoader
    @Environment(\.managedObjectContext) private var viewContext

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
                    .environment(\.managedObjectContext, viewContext)
                }
                
                CatalogableMenuView(viewModel: viewModel)
                
            }.navigationTitle("Catalog")
            .listStyle(InsetGroupedListStyle())
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
