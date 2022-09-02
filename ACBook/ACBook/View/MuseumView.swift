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
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Museum")
    }
}
