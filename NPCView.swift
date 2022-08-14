//
//  NPCView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct NPCView: View{
    
    @ObservedObject var viewModel: DataLoader
    @State var disableAdd: Bool = false
    
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
                }

            }
            .toolbar{
                ToolbarItemGroup(placement: .bottomBar){
                    Spacer()
                    Button{
                        disableAdd = true
                    }
                    label: {disableAdd ? Text("Already in your island") : Text("Add to your island")}
                        .disabled(disableAdd)
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
}
