//
//  MuseumView.swift
//  ACBook
//
//  Created by Lorenzo on 05/08/22.
//

import SwiftUI

struct MuseumView: View {
    @ObservedObject var viewModel: DataLoader
    var body: some View {
        List(){
            CatalogableMenuView(viewModel:viewModel, all: false)
            NavigationLink(destination: StatisticsView(viewModel: viewModel)){
                Label("Statistics", systemImage: "plus.forwardslash.minus")
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Museum")
    }
}
