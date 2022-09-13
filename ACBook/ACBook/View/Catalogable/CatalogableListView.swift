//
//  VillagerListView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct CatalogableListView: View {
    
    @ObservedObject var viewModel: DataLoader
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var residents: FetchedResults<Resident>
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var fossils: FetchedResults<FossilsPlayer>
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var arts: FetchedResults<ArtPlayer>
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var creatures: FetchedResults<CreaturePlayer>
    @State var searchQuery = ""

    
    var type: GameEntity
    var museum: Bool = false
    
    var body: some View{
        List(getItems(), id: \.id){ item in
            NavigationLink( destination: CatalogableDetailsView(viewModel: viewModel,disableAdd: isPresent(item: item), item: item)){
                CatalogableRowView(viewModel: viewModel, item: item)
                    .environment(\.managedObjectContext, viewContext)
            }
        }
        .navigationTitle(Text(type.rawValue.capitalized))
        .listStyle(InsetGroupedListStyle())
    }
    
    private func isPresent(item: Catalogable) -> Bool{
        switch(item.getType()){
        case .villagers:
            return !residents.filter{ res in
                res.id == Int64(item.getID())
            }.isEmpty
        case .fossils:
            return !fossils.filter{ fos in
                fos.id == Int64(item.getID())
            }.isEmpty
        case .arts:
            return !arts.filter{ art in
                art.id == Int64(item.getID())
            }.isEmpty
        default:
            return !creatures.filter{ cre in
                cre.id == Int64(item.getID())
            }.isEmpty

        }

    }
    
    private func getItems() -> [Catalogable]{
        let items = viewModel.loadListOfEntity(type: type)
        if(museum){
            return items.filter{item in
                isPresent(item: item)
            }
        }
        return items
    }

}
