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
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                
                CircleImage(viewModel: viewModel, image: URL(string: "https://acnhcdn.com/latest/NpcIcon/brd06.png")!)
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    .offset(y: -50)
                    .padding(.bottom, -50)
                
                Text("Admiral")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
                List{

                    Section(header: Text("Villager's information")) {
                        HInfo(key: "Gender", value: "Male")
                        HInfo(key: "Personality", value: "Cranky")
                        HInfo(key: "Species", value: "Bird")
                        HInfo(key: "Birthday", value: "27/01")
                        HInfo(key: "Styles", value: "Cool")
                    }
                    
                    Section(header: Text("House")) {
                        Image(uiImage: viewModel.images[2] ?? viewModel.notFoundImage!)
                            .resizable()
                            .frame(width: 150, height: 150, alignment: .center)
                            .onAppear {
                                //viewModel.loadImage(url: image)
                                viewModel.loadImage(url: URL(string: "https://acnhcdn.com/drivesync/render/houses/brd06_39_Admiral.png")!, id:2)
                            }.frame(width: UIScreen.main.bounds.width, alignment: .center)
                        CircleProgressView(isLoading: $viewModel.isLoading)
                    }
                }.listStyle(InsetGroupedListStyle())
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
        .navigationTitle("Admiral")
        .navigationBarTitleDisplayMode(.inline)
    }

}

struct NPCView_Previews: PreviewProvider {
    static var previews: some View {
        NPCView(viewModel: DataLoader())
    }
}
