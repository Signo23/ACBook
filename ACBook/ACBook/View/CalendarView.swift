//
//  CalendarView.swift
//  ACBook
//
//  Created by Lorenzo on 02/09/22.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var viewModel: DataLoader
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var days: FetchedResults<Day>
    
    @State var showAddView: Bool = false
    var body: some View {
        NavigationView{
            List(){
                /*if(!days.isEmpty){
                    ForEach(days, id: \.date){ day in
                        NavigationLink(destination: CalenadarDetailsView(isNewDay: false, viewModel: viewModel, day: day).environment(\.managedObjectContext, viewContext)){
                            Text("\((day.date?.formatted(date: .complete, time: .omitted))!)")
                        }
                    }
                }*/

                /*Section(header: Text("August")){
                    NavigationLink(destination: CalenadarDetailsView(isNewDay: false, viewModel: viewModel).environment(\.managedObjectContext, viewContext)){
                        Text("Monday 29 August 2022")

                    }
                    NavigationLink(destination: CalenadarDetailsView(isNewDay: false, viewModel: viewModel)){
                        Text("Monday 22 August 2022")

                    }
                    NavigationLink(destination: CalenadarDetailsView(isNewDay: false, viewModel: viewModel)){
                        Text("Friday 19 August 2022")

                    }
                }*/
                
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
                CalenadarDetailsView(isNewDay: true, viewModel: viewModel, day: Day(context: viewContext))
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}
