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
    @Published var imagesCritterpedia: [Int:UIImage] = [:]
    @Published var imagesFakeArt: [Int:UIImage] = [:]

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
    
    func loadImageCritterpedia(url:URL, id: Int){
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = data {
                    self.imagesCritterpedia[id] = UIImage(data: imageData)!
                    self.isLoading = false
                }
            }
        }
    }
    
    func loadImageFakeArt(url:URL, id: Int){
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = data {
                    self.imagesFakeArt[id] = UIImage(data: imageData)!
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
    
    func addVillagerToIsland(id: Int, viewContext: NSManagedObjectContext) {
        withAnimation{
            let newItem = Resident(context: viewContext)
            newItem.id = Int64(lastID + 1)
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func add(item: Catalogable, viewContext: NSManagedObjectContext) {
        withAnimation{
            switch(item.getType()){
            case .villagers:
                let villager = Resident(context: viewContext)
                villager.id = Int64(item.getID())
                print(villager);
            case .fossils:
                let fossil = FossilsPlayer(context: viewContext)
                fossil.id = Int64(item.getID())
                fossil.date = Date()
            case .arts:
                let art = ArtPlayer(context: viewContext)
                art.id = Int64(item.getID())
                art.date = Date()
            default:
                let creature = CreaturePlayer(context: viewContext)
                creature.id = Int64(item.getID())
                creature.date = Date()
            }
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteItem(item: NSManagedObject, viewContext: NSManagedObjectContext) {
        withAnimation{
            viewContext.delete(item)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
