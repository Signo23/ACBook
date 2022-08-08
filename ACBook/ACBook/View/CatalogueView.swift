//
//  CatalogueView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct CatalogueView: View {
    var body: some View {
        NavigationView{
            List(){
                Section(header: Text("")){
                    NavigationLink(destination: MuseumView()){
                        Label("Museum", systemImage: "building.columns.fill")

                    }
                }
                Section(){
                    NavigationLink(destination: VillagerListView(viewModel: DataLoader(), type: .villagers)){
                        Label("Villagers", systemImage: "hare.fill")
                    }
                }
                
                CollectionableMenuView()
                
            }.navigationTitle("Catalogue")
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct CatalogueView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueView()
    }
}
