//
//  CollectionableMenuView.swift
//  ACBook
//
//  Created by Lorenzo on 05/08/22.
//

import SwiftUI

struct CollectionableMenuView: View {
    var viewModel: DataLoader
    @State var all: Bool = true
    
    var body: some View {
        Section(){
            NavigationLink(destination: getDestination(.insects)){
                Label("Insects", systemImage: "ant.fill")
            }
            NavigationLink(destination: getDestination(.fish)){
                Label("Fish", systemImage: "fish.fill")
            }
            NavigationLink(destination: getDestination(.sea_creatures)){
                Label("Sea creatures", systemImage: "tortoise.fill")
            }
        }
        
        Section(){
            NavigationLink(destination: getDestination(.fossils)){
                Label("Fossils", systemImage: "fossil.shell.fill")
            }
            NavigationLink(destination: getDestination(.arts)){
                Label("Arts", systemImage: "photo.artframe")
            }
        }
    }
    
    func getDestination(_ type: GameEntity) -> AnyView {
        return all ? AnyView(VillagerListView(viewModel: self.viewModel, type: type)) : AnyView(EmptyView())
    }
}
