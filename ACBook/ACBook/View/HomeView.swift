//
//  HomeView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView{
            Text("Diary")
                .tabItem {
                    Label("Diary", systemImage: "book")
                }
            
            CatalogueView()
                .tabItem{
                    Label("Catalogue", systemImage: "leaf")
                }
            
            UserView()
                .tabItem {
                    Label("User", systemImage: "person")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
