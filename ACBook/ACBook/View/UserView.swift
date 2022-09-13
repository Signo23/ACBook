//
//  UserView.swift
//  ACBook
//
//  Created by Lorenzo on 05/08/22.
//

import SwiftUI
import CoreData

struct UserView: View {
    @State var userName: String = "Signo"
    @State var islandName: String = "Hoshimori"
    var viewModel: DataLoader
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var residents: FetchedResults<Resident>
    
    
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
}

