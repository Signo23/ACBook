//
//  IconView.swift
//  ACBook
//
//  Created by Lorenzo on 05/08/22.
//

import SwiftUI

struct IconView: View {
    var villager: Villager
    @ObservedObject var viewModel: DataLoader
    var body: some View {
        VStack(){
            Image(uiImage: viewModel.images[villager.getID()] ?? viewModel.notFoundImage)
                .resizable()
                .background(.blue)
                .clipShape(Circle())
                .frame(width: 50, height: 50)
                .onAppear(){
                    viewModel.loadImage(url: villager.getMainImageURL(), id: villager.getID())
                }
            HStack(){
                Text(villager.getName())
                    .dynamicTypeSize(.small)
            }
        }
        .frame(width: 55, height: 75, alignment: .leading)
        .background(.bar)
        .cornerRadius(5)
    }
}
