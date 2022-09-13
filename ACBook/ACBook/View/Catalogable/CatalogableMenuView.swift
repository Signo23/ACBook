//
//  CollectionableMenuView.swift
//  ACBook
//
//  Created by Lorenzo on 05/08/22.
//

import SwiftUI

struct CatalogableMenuView: View {
    var viewModel: DataLoader
    @State var all: Bool = true
    
    var body: some View {
        Section(){
            NavigationLink(destination: CatalogableListView(viewModel: self.viewModel, type: .insects, museum: !all)){
                Label("Insects", systemImage: "ant.fill")
            }
            NavigationLink(destination: CatalogableListView(viewModel: self.viewModel, type: .fish, museum: !all)){
                Label("Fish", systemImage: "fish.fill")
            }
            NavigationLink(destination: CatalogableListView(viewModel: self.viewModel, type: .sea_creatures, museum: !all)){
                Label("Sea creatures", systemImage: "tortoise.fill")
            }
        }
        
        Section(){
            NavigationLink(destination: CatalogableListView(viewModel: self.viewModel, type: .fossils, museum: !all)){
                Label("Fossils", systemImage: "fossil.shell.fill")
            }
            NavigationLink(destination: CatalogableListView(viewModel: self.viewModel, type: .arts, museum: !all)){
                Label("Arts", systemImage: "photo.artframe")
            }
        }
    }
}
