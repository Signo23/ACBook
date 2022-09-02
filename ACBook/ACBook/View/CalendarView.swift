//
//  CalendarView.swift
//  ACBook
//
//  Created by Lorenzo on 02/09/22.
//

import SwiftUI

struct CalendarView: View {
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
        }
        .navigationTitle("Diary")
        .listStyle(InsetGroupedListStyle())
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
