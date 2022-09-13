//
//  NPCView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI
import CoreData

struct CatalogableDetailsView: View{
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: DataLoader
    @State var disableAdd: Bool
    
    var item: Catalogable
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    var residents: FetchedResults<Resident>
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    var fossils: FetchedResults<FossilsPlayer>
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    var arts: FetchedResults<ArtPlayer>
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    var creatures: FetchedResults<CreaturePlayer>
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                
                CircleImage(viewModel: viewModel, item: item)
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    //.offset(y: -75)
                    //.padding(.bottom, -50)
                
                if(item.getType() == .villagers){
                    villagerInfo
                        .listStyle(InsetGroupedListStyle())
                } else if(item.getType() == .fish || item.getType() == .sea_creatures || item.getType() == .insects){
                    creatureInfo
                        .listStyle(InsetGroupedListStyle())
                } else if(item.getType() == .arts) {
                    artsInfo
                        .listStyle(InsetGroupedListStyle())
                } else{
                    fossilsInfo
                        .listStyle(InsetGroupedListStyle())
                }

            }
            .toolbar{
                ToolbarItemGroup(placement: .bottomBar){
                    Spacer()
                    Button{
                        if(disableAdd){
                            disableAdd = false
                            viewModel.deleteItem(item: getItemCore(), viewContext: viewContext)
                        }
                        else {
                            disableAdd = true
                            viewModel.add(item: item, viewContext: viewContext)
                        }
                    }
                label: {disableAdd ? (item.getType() == .villagers ? Text("Remove from island").foregroundColor(.red): Text("Uncollect")
                    .foregroundColor(.red)) : (item.getType() == .villagers ? Text("Add to island"): Text("Collect"))}
                }
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
        .navigationTitle(item.getName().capitalized)
        //.navigationBarTitleDisplayMode(.inline)
    }
    

    private var villagerInfo: some View {
            let villager: Villager = item as! Villager
            return List{
                
                Section(header: Text("Villager's informations")) {
                    HInfo(key: "Gender", value: villager.gender)
                    HInfo(key: "Personality", value: villager.personality)
                    HInfo(key: "Species", value: villager.species)
                    HInfo(key: "Birthday", value: villager.birthday)
                    HInfo(key: "Style", value: villager.style)
                }
                
                Section(header: Text("House")) {
                    Image(uiImage: viewModel.imagesHouse[villager.id] ?? viewModel.notFoundImage)
                        .resizable()
                        .frame(width: 150, height: 150, alignment: .center)
                        .onAppear {
                            viewModel.loadImageHouse(url: villager.houseURL, id: villager.id)
                        }.frame(width: UIScreen.main.bounds.width, alignment: .center)
                    CircleProgressView(isLoading: $viewModel.isLoading)
                }
            }

    }

    
    private var creatureInfo: some View{
        let creature: Creature = item as! Creature
        return List {
            Section(header: Text("Informations")) {
                HInfo(key: "Sell", value: String(creature.sell))
                if (creature.getType() == .insects){
                    HInfo(key: "Wheater", value: creature.weather )
                }
                HInfo(key: "Nord", value: creature.getActiveMothNorthDescription())
                HInfo(key: "Sud", value: creature.getActiveMothSouthDescription())
                HInfo(key: "Active Hours", value: creature.getHoursDescription())
            }
            
            Section() {
                Image(uiImage: viewModel.imagesCritterpedia[creature.getID()] ?? viewModel.notFoundImage)
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .onAppear {
                        viewModel.loadImageCritterpedia(url: creature.critterpediaImageURL, id: creature.id)
                    }.frame(width: UIScreen.main.bounds.width, alignment: .center)
                CircleProgressView(isLoading: $viewModel.isLoading)
            }
        }
    }
    
    private var fossilsInfo: some View{
        let fossil: Fossils = item as! Fossils
        return List{
            Section(header: Text("Informations")) {
                HInfo(key: "Fossil group", value: fossil.fossilGroup)
                HInfo(key: "Source", value: fossil.source)
                HInfo(key: "Sell", value: String(fossil.sell))
            }
        }
    }
    
    private var artsInfo: some View{
        let art: Art = item as! Art
        return List{
            Section(header: Text("Informations")) {
                HInfo(key: "Real name", value: art.realName)
                HInfo(key: "Artist", value: art.artist)
                HInfo(key: "Price", value: String(art.price))
                HInfo(key: "Sell", value: String(art.sell))
            }
            
            if(art.getMainImageURL() != art.fakeImageURL){
                Section(header: Text("Fake")) {
                    Image(uiImage: viewModel.imagesFakeArt[art.getID()] ?? viewModel.notFoundImage)
                        .resizable()
                        .frame(width: 150, height: 150, alignment: .center)
                        .onAppear {
                            viewModel.loadImageFakeArt(url: art.fakeImageURL, id: art.id)
                        }.frame(width: UIScreen.main.bounds.width, alignment: .center)
                    CircleProgressView(isLoading: $viewModel.isLoading)
                }
            }
        }
    }
    
    private func getItemCore() -> NSManagedObject{
        
        switch(item.getType()){
        case .villagers:
            return residents.filter{ res in
                res.id == Int64(item.getID())
            }.first!
        case .fossils:
            return fossils.filter{ fos in
                fos.id == Int64(item.getID())
            }.first!
        case .arts:
            return arts.filter{ art in
                art.id == Int64(item.getID())
            }.first!
        default:
            return creatures.filter{ cre in
                cre.id == Int64(item.getID())
            }.first!

        }
        
    }
}
