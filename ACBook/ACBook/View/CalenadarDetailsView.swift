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
import CoreData

struct CalenadarDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    var isNewDay: Bool
    var viewModel: DataLoader
    @State private var fullText: String
    @State private var date: Date
    @State private var isPositionDisabled: Bool = false
    @FocusState private var focusedFiels: Bool
    
    //Camera
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    //Map
    @State private var position: CLLocationCoordinate2D?
    @ObservedObject var locationViewModel = LocationViewModel()
    
    private var day: Day
    
    init(isNewDay: Bool, viewModel: DataLoader, day: Day) {
        self.day = day
        self.isNewDay = isNewDay
        self.viewModel = viewModel
        _fullText = State(initialValue: day.notes ?? "")
        _date = State(initialValue: day.date ?? Date())
        if(day.photo != nil){
            _selectedImage = State(initialValue: dataToImg(data: day.photo!))
        }
        if(day.long != 0.0 && day.lat != 0.0){
            _position = State(initialValue: CLLocationCoordinate2D(latitude: day.lat, longitude: day.long))
        }
    }
    
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
        .toolbar{
            ToolbarItemGroup(){
                Button("Save"){
                    day.notes = fullText
                    day.date = date
                    day.long = position?.longitude ?? 0.0
                    day.lat = position?.latitude ?? 0.0
                    if(selectedImage != nil){
                        day.photo = imgToData(image: selectedImage!)
                    }
                    dismiss()
                    do{
                        try viewContext.save()
                    }catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }

                }
            }
        }

    }
    
    func mapButton() -> some View {
        Menu(){
            Button(){
                locationViewModel.startMySignificantLocationChanges()
                position = CLLocationCoordinate2D(latitude: locationViewModel.latitude, longitude: locationViewModel.longitude)
                self.isPositionDisabled = true
            } label: {
                Label("Take position", systemImage: "map")
            }.disabled(isPositionDisabled)
        } label: {
            Label("Take position", systemImage: "map")
        }
    }
    
    func imgToData(image: UIImage) -> Data{
        (image.pngData())!
    }
    
    func dataToImg(data: Data) -> UIImage{
        UIImage(data: data)!
    }

}
