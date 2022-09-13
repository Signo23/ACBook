//
//  NPCView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct CatalogableDetailsView: View{
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: DataLoader
    @State var disableAdd: Bool = false
    @State var isInMuseum: Bool = false
    
    var item: Catalogable
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                
                CircleImage(viewModel: viewModel, item: item)
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    .offset(y: -50)
                    .padding(.bottom, -50)
                
                Text(item.getName().capitalized)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
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
                    if(item.getType() == .villagers){
                        Spacer()
                        Button{
                            disableAdd = !disableAdd
                            viewModel.add(item: item, viewContext: viewContext)
                        }
                        label: {disableAdd ? Text("Remove from island").foregroundColor(.red) : Text("Add to island")}
                    } else {
                        if(disableAdd) {
                            Button{
                                disableAdd = false
                                isInMuseum = false
                            }
                            label: {
                                Text("Uncollect")
                                    .foregroundColor(.red)
                            }
                            Button{
                                isInMuseum = !isInMuseum
                            }
                            label: {isInMuseum ? Text("Remove from museum").foregroundColor(.red) : Text("Add to museum")}
                        } else {
                            Spacer()
                            Button{
                                disableAdd = true
                            }
                            label: {Text("Collect")}
                        }
                    }
                }
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
        .navigationTitle(item.getName().capitalized)
        .navigationBarTitleDisplayMode(.inline)
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
                    .frame(width: 150, height: 150)
                    .onAppear {
                        viewModel.loadImageCritterpedia(url: creature.critterpediaImageURL, id: creature.id)
                    }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
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
                        .frame(width: 150, height: 150)
                        .onAppear {
                            viewModel.loadImageFakeArt(url: art.fakeImageURL, id: art.id)
                        }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    CircleProgressView(isLoading: $viewModel.isLoading)
                }
            }
        }
    }
}
