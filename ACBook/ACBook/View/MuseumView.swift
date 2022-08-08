//
//  MuseumView.swift
//  ACBook
//
//  Created by Lorenzo on 05/08/22.
//

import SwiftUI

struct MuseumView: View {
    var body: some View {
        List(){
            CollectionableMenuView(all: false)
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Museum")
    }
}

struct MuseumView_Previews: PreviewProvider {
    static var previews: some View {
        MuseumView()
    }
}
