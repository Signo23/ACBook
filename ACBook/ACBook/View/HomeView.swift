//
//  HomeView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct HomeView: View {
    var viewModel: DataLoader = DataLoader()
    var body: some View {
        TabView{
            CalendarView(viewModel: viewModel)
                .tabItem {
                    Label("Diary", systemImage: "book")
                }
            
            CatalogView(viewModel: viewModel)
                .tabItem{
                    Label("Catalog", systemImage: "leaf")
                }
            
            UserView(viewModel: viewModel)
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
