//
//  VillagerRowView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct CatalogableRowView: View {
    @ObservedObject var viewModel: DataLoader
    
    var item: Catalogable
    
    var body: some View {
        HStack{
            Image(uiImage: viewModel.images[item.getID()] ?? viewModel.notFoundImage)
                .resizable()
                .background(.bar)
                .clipShape(Rectangle())
                .frame(width: 50, height: 50, alignment: .leading)
                .cornerRadius(5)
                .onAppear(){
                    viewModel.loadImage(url: item.getMainImageURL(), id: item.getID())
                }
            Text(item.getName().capitalized)
        }
    }
}
