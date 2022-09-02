//
//  IconView.swift
//  ACBook
//
//  Created by Lorenzo on 05/08/22.
//

import SwiftUI

struct IconView: View {
    var body: some View {
        VStack(spacing: 20){
            Image(uiImage: UIImage(named: "std")!)
                .resizable()
                .clipShape(Circle())
            Text("Villager")
        }
        .background(.bar)
        .cornerRadius(5)
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView()
    }
}
