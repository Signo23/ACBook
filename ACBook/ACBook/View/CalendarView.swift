//
//  CalendarView.swift
//  ACBook
//
//  Created by Lorenzo on 02/09/22.
//

import SwiftUI

struct CalendarView: View {
    var viewModel: DataLoader
    @State var showAddView: Bool = false
    var body: some View {
        NavigationView{
            List(){
                Section(header: Text("August")){
                    NavigationLink(destination: CalenadarDetailsView(isNewDay: false, viewModel: viewModel)){
                        Text("Monday 29 August 2022")

                    }
                    NavigationLink(destination: CalenadarDetailsView(isNewDay: false, viewModel: viewModel)){
                        Text("Monday 22 August 2022")

                    }
                    NavigationLink(destination: CalenadarDetailsView(isNewDay: false, viewModel: viewModel)){
                        Text("Friday 19 August 2022")

                    }
                }
                
                Section(header: Text("June")){
                    NavigationLink(destination: EmptyView()){
                        Text("Monday 11 June 2022")

                    }
                }
            }
            .navigationTitle("Diary")
            .listStyle(InsetGroupedListStyle())
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar{
                ToolbarItem{
                    Button(action: {
                        showAddView = true
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $showAddView) {
                CalenadarDetailsView(isNewDay: true, viewModel: viewModel)
            }
        }
    }
}
