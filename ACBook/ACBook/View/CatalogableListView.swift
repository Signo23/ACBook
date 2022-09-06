//
//  VillagerListView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct CatalogableListView: View {
    
    @ObservedObject var viewModel: DataLoader
    @State var searchQuery = ""

    
    var type: GameEntity
    
    var body: some View{
        List(viewModel.loadListOfEntity(type: type), id: \.id){ item in
            NavigationLink( destination: CatalogableDetailsView(viewModel: viewModel, item: item)){
                CatalogableRowView(viewModel: viewModel, item: item)
            }
        }
        .navigationTitle(Text(type.rawValue.capitalized))
        .listStyle(InsetGroupedListStyle())
    }

}
