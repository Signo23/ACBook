//
//  CircleImage.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

import SwiftUI

struct CircleImage : View {
    @ObservedObject var viewModel: DataLoader
    var item: Catalogable
    
    var body: some View {
        ZStack {
            Image(uiImage: viewModel.images[item.getID()] ?? viewModel.notFoundImage)
                .resizable()
                .background(.bar)
                .frame(width: 150, height: 150, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 7)
                .onAppear {
                    viewModel.loadImage(url: item.getMainImageURL(), id:item.getID())
                }
            CircleProgressView(isLoading: $viewModel.isLoading)
        }
    }
}

struct CircleProgressView: View {
    @Binding var isLoading: Bool
    var body: some View {
        if isLoading {
            ProgressView()
        }
    }
}
