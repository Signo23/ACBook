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
                
                Text(item.getName())
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
                villagerInfo
                .listStyle(InsetGroupedListStyle())
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
        .navigationTitle(item.getName())
        .navigationBarTitleDisplayMode(.inline)
    }

    private var villagerInfo: some View {
            let villager: Villager = item as! Villager
            return List{
                
                Section(header: Text("Villager's information")) {
                    HInfo(key: "Gender", value: villager.gender)
                    HInfo(key: "Personality", value: villager.personality)
                    HInfo(key: "Species", value: villager.species)
                    HInfo(key: "Birthday", value: villager.birthday)
                    HInfo(key: "Style", value: villager.style)
                }
                
                Section(header: Text("House")) {
                    Image(uiImage: viewModel.imagesHouse[villager.id] ?? viewModel.notFoundImage!)
                        .resizable()
                        .frame(width: 150, height: 150, alignment: .center)
                        .onAppear {
                            viewModel.loadImageHouse(url: villager.houseURL, id: villager.id)
                        }.frame(width: UIScreen.main.bounds.width, alignment: .center)
                    CircleProgressView(isLoading: $viewModel.isLoading)
                }
            }

    }
}
