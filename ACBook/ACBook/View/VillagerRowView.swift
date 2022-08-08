//
//  VillagerRowView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct VillagerRowView: View {
    @ObservedObject var viewModel = DataLoader()
    
    var item: Catalogable
    
    var body: some View {
        HStack{
            Image(uiImage: viewModel.images[item.getID()] ?? viewModel.notFoundImage)
                .resizable()
                .frame(width: 50, height: 50, alignment: .leading)
                .onAppear(){
                    viewModel.loadImage(url: item.getMainImageURL(), id: item.getID())
                }
            Text(item.getName())
        }
    }
}
