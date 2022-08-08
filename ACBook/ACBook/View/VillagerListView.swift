//
//  VillagerListView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct VillagerListView: View {
    
    @ObservedObject var viewModel: DataLoader
    @State var searchQuery = ""

    
    var type: GameEntity
    
    var body: some View{
        List(viewModel.loadListOfEntity(type: type), id: \.id){ item in
            NavigationLink( destination: NPCView(viewModel: viewModel, item: item)){
                VillagerRowView(viewModel: viewModel, item: item)
            }
        }
        .navigationTitle(Text(type.rawValue.capitalized))
        .listStyle(InsetGroupedListStyle())
    }

}

