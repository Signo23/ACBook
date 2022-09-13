//
//  HomeView.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var viewModel: DataLoader = DataLoader()
    var body: some View {
        TabView{
            CalendarView(viewModel: viewModel)
                .tabItem {
                    Label("Diary", systemImage: "book")
                }
            
            CatalogView(viewModel: viewModel)
                .environment(\.managedObjectContext, viewContext)
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
