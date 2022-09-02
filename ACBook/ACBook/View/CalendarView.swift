//
//  CalendarView.swift
//  ACBook
//
//  Created by Lorenzo on 02/09/22.
//

import SwiftUI

struct CalendarView: View {
    @State var showAddView: Bool = false
    var body: some View {
        NavigationView{
            List(){
                Section(header: Text("August")){
                    NavigationLink(destination: EmptyView()){
                        Text("Monday 29 August 2022")

                    }
                    NavigationLink(destination: EmptyView()){
                        Text("Monday 22 August 2022")

                    }
                    NavigationLink(destination: EmptyView()){
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
                EmptyView()
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
