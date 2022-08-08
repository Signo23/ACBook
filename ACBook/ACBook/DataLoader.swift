//
//  DataLoader.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//
import Foundation
import SwiftUI
import CoreData

class DataLoader: ObservableObject {
    @Published var model = Modeldata<Villager>(fileName: "villagers.json")
    @Published var modelCreatures = Modeldata<Creature>(fileName: "creatures.json")
    @Published var modelArt = Modeldata<Art>(fileName: "arts.json")
    @Published var modelFossils = Modeldata<Fossils>(fileName: "fossils.json")
    @Published var images: [Int:UIImage] = [:]
    @Published var imagesHouse: [Int:UIImage] = [:]
    var isLoading = true
    var lastID: Int {
        UserDefaults.standard.integer(forKey: "lastID")
    }
    private var villagers: [Villager] {
        model.list
    }

    let notFoundImage = UIImage(named: "std")!

    
    func loadImage(url:URL, id: Int){
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = data {
                    self.images[id] = UIImage(data: imageData)!
                    self.isLoading = false
                }
            }
        }
    }
    
    func loadImageHouse(url:URL, id: Int){
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = data {
                    self.imagesHouse[id] = UIImage(data: imageData)!
                    self.isLoading = false
                }
            }
        }
    }
    
    func loadListOfEntity(type: GameEntity)-> [Catalogable] {
        switch(type){
        case.villagers:
            return villagers
        case .insects:
            return modelCreatures.list.filter { creature in
                creature.getType() == GameEntity.insects
            }
        case .fish:
            return modelCreatures.list.filter { creature in
                creature.getType() == GameEntity.fish
            }
        case .sea_creatures:
            return modelCreatures.list.filter { creature in
                creature.getType() == GameEntity.sea_creatures
            }
        case .fossils:
            return modelFossils.list
        case .arts:
            return modelArt.list
        }
    }
    
    
    
    /*func addItem(placeName: String, placeDesciption: String, image: String, city: String, latitude: String, longitude: String, viewContext: NSManagedObjectContext) {
        withAnimation{
            let newItem = PlaceEntity(context: viewContext)
            newItem.id = Int64(lastID + 1)
            newItem.name = placeName
            newItem.placeDescription = placeDesciption
            newItem.city = city
            newItem.latitude = Double(latitude) ?? 0.0
            newItem.longitude = Double(longitude) ?? 0.0
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteItems(places: [PlaceEntity], viewContext: NSManagedObjectContext) {
        withAnimation{
            for place in places {
                viewContext.delete(place)
            }
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }*/
}
