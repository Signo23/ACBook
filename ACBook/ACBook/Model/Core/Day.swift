//
//  Day.swift
//  ACBook
//
//  Created by Lorenzo Signoretti on 13/09/22.
//

import Foundation
import CoreData

extension Day{
    
    /// Function that fetches the request for the CoreData
    /// - Parameter predicate: predicate to add in the request
    /// - Returns: the rquest made
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Day> {
        let request = NSFetchRequest<Day>(entityName: "Day")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        return request
    }
}
