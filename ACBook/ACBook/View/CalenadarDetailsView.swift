//
//  CalenadarDetailsView.swift
//  ACBook
//
//  Created by Lorenzo on 03/09/22.
//

import SwiftUI
import UIKit
import Foundation
import MapKit

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
    
    //Map
    @State private var position: CLLocationCoordinate2D?
    @ObservedObject var locationViewModel = LocationViewModel()
    var body: some View {
        if(isNewDay){
            NavigationView{
                content()
                .navigationTitle("New day")
            }
        } else {
            content()
                .navigationTitle("Day's details")
        }
    }
    
    func content() -> some View {
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
                    .padding(.horizontal)
            }
            .onSubmit {
                print("Prova")
            }
            
            Section("Position"){
                mapButton()
                if position != nil {
                    MapView(locationCoordinates: position!)
                        .frame(height: 300)
                        .cornerRadius(15)
                }
            }

            Section("Photo"){
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
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
                }
            }

            


        }
        .onTapGesture {
            focusedFiels = false;
        }
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
    }
    
    func mapButton() -> some View {
        Menu(){
            Button(){
                locationViewModel.startMySignificantLocationChanges()
                latitude = String(format: "%1f", locationViewModel.latitude)
                longitude = String(format: "%1f", locationViewModel.longitude)
                position = CLLocationCoordinate2D(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude)
                
                self.isPositionDisabled = true
            } label: {
                Label("Take position", systemImage: "map")
            }.disabled(isPositionDisabled)
        } label: {
            Label("Take position", systemImage: "map")
        }
    }

}
