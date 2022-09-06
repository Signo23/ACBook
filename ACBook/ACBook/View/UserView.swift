//
//  UserView.swift
//  ACBook
//
//  Created by Lorenzo on 05/08/22.
//

import SwiftUI

struct UserView: View {
    @State var userName: String = "Signo"
    @State var islandName: String = "Hoshimori"
    var viewModel: DataLoader
    
    var body: some View {
        NavigationView(){
            List(){
                Section(header: Text("Passport")){
                    HStack(){
                        Image(uiImage: UIImage(named: "std")!)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                            .padding()
                        Spacer()
                        VStack(alignment: .trailing){
                            TextField("Name", text: $userName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField("Island", text: $islandName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    HInfo(key: "Native fruit", value: "Orange")
                    HInfo(key: "Hemisphere", value: "Nord")
                    HInfoFieldCode(key: "Switch code")
                    HInfoFieldCode(key: "Dream code")
                    HInfoFieldCode(key: "Creator ID")
                }
                
                Section(header: Text("Island residents")){
                    HStack(){
                        IconView(villager: viewModel.loadListOfEntity(type: .villagers)[0] as! Villager, viewModel: viewModel)
                        IconView(villager: viewModel.loadListOfEntity(type: .villagers)[1] as! Villager, viewModel: viewModel)
                        IconView(villager: viewModel.loadListOfEntity(type: .villagers)[2] as! Villager, viewModel: viewModel)
                        IconView(villager: viewModel.loadListOfEntity(type: .villagers)[3] as! Villager, viewModel: viewModel)
                        IconView(villager: viewModel.loadListOfEntity(type: .villagers)[4] as! Villager, viewModel: viewModel)
                    }
                    HStack(){
                        IconView(villager: viewModel.loadListOfEntity(type: .villagers)[5] as! Villager, viewModel: viewModel)
                        IconView(villager: viewModel.loadListOfEntity(type: .villagers)[6] as! Villager, viewModel: viewModel)
                        IconView(villager: viewModel.loadListOfEntity(type: .villagers)[7] as! Villager, viewModel: viewModel)
                        IconView(villager: viewModel.loadListOfEntity(type: .villagers)[8] as! Villager, viewModel: viewModel)
                        IconView(villager: viewModel.loadListOfEntity(type: .villagers)[9] as! Villager, viewModel: viewModel)
                    }
                    
                }
                Section(header: Text("Museum's donations")) {
                    ProgressView("Insects", value: 64, total: 80)
                        ProgressView("Fishes", value: 54, total: 80)
                        ProgressView("Sea creatures", value: 29, total: 40)
                        ProgressView("Fossils", value: 73, total: 73)
                        ProgressView("Arts", value: 12, total: 43)
                }
                
                Section(header: Text("Statistcs")){
                    HInfo(key: "Aug", value: "20")
                    Chart()
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("User")
        }
    }
}

