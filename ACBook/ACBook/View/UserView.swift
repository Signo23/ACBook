//
//  UserView.swift
//  ACBook
//
//  Created by Lorenzo on 05/08/22.
//

import SwiftUI
import CoreData

struct UserView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var userName: String
    @State var islandName: String
    @State var switchCode: String
    @State var dreamCode: String
    @State var creatorId: String
    @State private var isSaveEnable: Bool = false
    @State var fruit: String
    @State var hemisphere: String

    var viewModel: DataLoader
    var playerInfo: Player
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var residents: FetchedResults<Resident>
    
    
    
    init(viewModel: DataLoader, playerInfo: Player) {
        print(playerInfo)
        self.viewModel = viewModel
        self.playerInfo = playerInfo
        _userName = State(initialValue: playerInfo.name ?? "")
        _islandName = State(initialValue: playerInfo.islandName ?? "")
        _switchCode = State(initialValue: playerInfo.switchID ?? "")
        _dreamCode = State(initialValue:playerInfo.dream ?? "")
        _creatorId = State(initialValue:playerInfo.creator ?? "")
        _fruit = State(initialValue:playerInfo.fruit ?? "Select a fruit")
        _hemisphere = State(initialValue:playerInfo.hem ?? "Select an hemisphere")
    }
    
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
                                .onSubmit {
                                    isSaveEnable = true
                                }
                            TextField("Island", text: $islandName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onSubmit {
                                    isSaveEnable = true
                                }
                        }
                    }
                    HStack(){
                        Text("Native fruit")
                        Spacer()
                        Menu(getFruit()){
                            Button("Apple"){
                                fruit = "Apple"
                                isSaveEnable = !isSaveEnable

                            }
                            Button("Pear"){
                                fruit = "Pear"
                                isSaveEnable = !isSaveEnable

                            }

                            Button("Peach"){
                                fruit = "Peach"
                                isSaveEnable = !isSaveEnable

                            }
                            Button("Orange"){
                                fruit = "Orange"
                                isSaveEnable = !isSaveEnable

                            }
                            Button("Cherry"){
                                fruit = "Cherry"
                                isSaveEnable = !isSaveEnable

                            }

                        }
                    }
                    HStack(){
                        Text("Hemisphere")
                        Spacer()
                        Menu(getHemisphere()){
                            Button("North"){
                                hemisphere = "North"
                                isSaveEnable = true
                            }
                            Button("South"){
                                hemisphere = "South"
                                isSaveEnable = true
                            }
                        }
                    }
                    
                    HInfoFieldCode(key: "Switch code", code: switchCode)
                        .onSubmit {
                            isSaveEnable = true
                        }
                    HInfoFieldCode(key: "Dream code", code: dreamCode)
                        .onSubmit {
                            isSaveEnable = true
                        }
                    HInfoFieldCode(key: "Creator ID", code: creatorId)
                        .onSubmit {
                            isSaveEnable = true
                        }
                    Button("Save"){
                        isSaveEnable = !isSaveEnable
                        //self.userName = playerInfo.name!
                        playerInfo.name = userName
                        playerInfo.islandName = islandName
                        playerInfo.fruit = fruit
                        playerInfo.hem = hemisphere
                        playerInfo.switchID = switchCode
                        playerInfo.dream = dreamCode
                        playerInfo.creator = creatorId
                        viewModel.savePlayerInfo(player: playerInfo, viewContext: viewContext)
                    }.disabled(!isSaveEnable)
                }
                Section(header: Text("Island residents")){
                    HStack(){
                        ForEach(getResidents().prefix(5), id: \.id){ vil in
                            IconView(villager: vil, viewModel: viewModel)
                        }
                    }
                    if(getResidents().count > 5){
                        HStack{
                            ForEach(getSecondLine(villagers: getResidents()), id: \.id){ vil in
                                IconView(villager: vil, viewModel: viewModel)
                            }
                        }
                    }
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("User")
        }
    }
    
    func getResidents() -> [Villager]{
        let villagers = viewModel.loadListOfEntity(type: .villagers)
        var final: [Villager] = []
        var ids: [Int64] = []
        for res in residents {
            ids.append(res.id)
        }
        for vil in villagers {
            if(ids.contains(Int64(vil.getID()))){
                final.append(vil as! Villager)
            }
        }
        return final
    }
    
    private func getSecondLine(villagers: [Villager]) -> [Villager]{
        var second: [Villager] = villagers
        second.removeFirst()
        second.removeFirst()
        second.removeFirst()
        second.removeFirst()
        second.removeFirst()
        return second
    }
    
    private func getFruit() -> String{
        return fruit
    }
    
    private func getHemisphere() -> String{
        return hemisphere
    }
    
    private func getPlayerIslandName() -> Binding<String>{
        islandName = playerInfo.islandName!
        return $islandName
    }
    /*

    private func getPlayerSwitchCode() -> String{
        if(!playerInfo.isEmpty){
            switchCode = playerInfo.first?.switchID ?? ""
        }
        return switchCode
    }
    private func getPlayerDreamCode() -> String{
        if(!playerInfo.isEmpty){
            dreamCode = playerInfo.first?.dream ?? ""
        }
        return dreamCode
    }
    private func getPlayerCreatorId() -> String{
        if(!playerInfo.isEmpty){
            creatorId = playerInfo.first?.creator ?? ""
        }
        return creatorId
    }*/
    
}

