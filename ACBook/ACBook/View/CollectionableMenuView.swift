//
//  CollectionableMenuView.swift
//  ACBook
//
//  Created by Lorenzo on 05/08/22.
//

import SwiftUI

struct CollectionableMenuView: View {
    
    @State var all: Bool = true
    
    var body: some View {
        Section(){
            NavigationLink(destination: getDestination(.villagers)){
                Label("Insects", systemImage: "ant.fill")
            }
            NavigationLink(destination: getDestination(.villagers)){
                Label("Fish", systemImage: "fish.fill")
            }
            NavigationLink(destination: getDestination(.villagers)){
                Label("Sea creatures", systemImage: "tortoise.fill")
            }
        }
        
        Section(){
            NavigationLink(destination: getDestination(.villagers)){
                Label("Fossils", systemImage: "fossil.shell.fill")
            }
            NavigationLink(destination: getDestination(.villagers)){
                Label("Arts", systemImage: "photo.artframe")
            }
        }
    }
    
    func getDestination(_ type: GameEntity) -> AnyView {
        return all ? AnyView(VillagerListView(viewModel: DataLoader(), type: type)) : AnyView(EmptyView())
    }
}

struct CollectionableMenuView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionableMenuView()
    }
}
