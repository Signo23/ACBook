//
//  IconView.swift
//  ACBook
//
//  Created by Lorenzo on 05/08/22.
//

import SwiftUI

struct IconView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack(spacing: 20){
                Image(uiImage: UIImage(named: "std")!)
                    .resizable()
                    .clipShape(Circle())
                    .shadow(radius: 3)
                Text("Villager")
                    .foregroundColor(.white)
            }
            //.background(.secondary) iOS15
            //.cornerRadius(15)
        }
        .cornerRadius(5)
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView()
    }
}
