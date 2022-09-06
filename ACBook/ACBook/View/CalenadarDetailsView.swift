//
//  CalenadarDetailsView.swift
//  ACBook
//
//  Created by Giusy Messina on 03/09/22.
//

import SwiftUI
import UIKit
import Foundation

struct CalenadarDetailsView: View {
    var isNewDay: Bool
    var viewModel: DataLoader
    var helper: PhotoHelper = PhotoHelper()
    @State var latitude = ""
    @State var longitude = ""
    @State private var fullText = "Today the museum reach his max expansion"
    @State private var date = Date()
    @FocusState private var focusedFiels: Bool
    
    @ObservedObject var locationViewModel = LocationViewModel()

    var body: some View {
        if(isNewDay){
            NavigationView{
                content
                .navigationTitle("New day")
            }
        } else {
            content
                .navigationTitle("Day's details")
        }
    }
    
    private var content: some View {
        List(){
            DatePicker(
                    "Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
            .disabled(!isNewDay)
            Section(header: Text("Day's notes")){
                TextEditor(text: $fullText)
                    .focused($focusedFiels)
                    .submitLabel(.done)
                    .foregroundColor(.black)
                    .padding(.horizontal)
            }
            .onSubmit {
                print("Prova")
            }
            Section(header: Text("Day's information")){
                Menu(){
                    Button(){
                        helper.openCameraButton(sender: helper)
                    } label: {
                        Label("Photo", systemImage: "camera")
                    }
                    Button(){
                        helper.openPhotoLibraryButton(sender: helper)
                    } label: {
                        Label("Library", systemImage: "photo")
                    }
                } label : {
                    Label("Photo", systemImage: "camera")
                }
                Button(){
                    locationViewModel.startMySignificantLocationChanges()
                    latitude = String(format: "%1f", locationViewModel.latitude)
                    longitude = String(format: "%1f", locationViewModel.longitude)
                } label: {
                    Label("Take position", systemImage: "map")
                }
            }
        }
        .onTapGesture {
            focusedFiels = false;
        }
    }

}


struct CalenadarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CalenadarDetailsView(isNewDay: true, viewModel: DataLoader())
    }
}
