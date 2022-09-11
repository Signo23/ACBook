//
//  CalenadarDetailsView.swift
//  ACBook
//
//  Created by Lorenzo on 03/09/22.
//

import SwiftUI
import UIKit
import Foundation

struct CalenadarDetailsView: View {
    var isNewDay: Bool
    var viewModel: DataLoader
    @State var latitude = ""
    @State var longitude = ""
    @State private var fullText = "Today the museum reach his max expansion"
    @State private var date = Date()
    @State private var isPositionDisabled: Bool = false
    @FocusState private var focusedFiels: Bool
    
    //Camera
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
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
                        self.sourceType = .camera
                        self.isImagePickerDisplay.toggle()
                    } label: {
                        Label("Photo", systemImage: "camera")
                    }
                    Button(){
                        self.sourceType = .photoLibrary
                        self.isImagePickerDisplay.toggle()
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
                    self.isPositionDisabled = true
                } label: {
                    Label("Take position", systemImage: "map")
                }.disabled(isPositionDisabled)
            }
        }
        .onTapGesture {
            focusedFiels = false;
        }
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
    }

}
