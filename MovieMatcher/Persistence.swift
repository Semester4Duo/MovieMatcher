//
//  Persistence.swift
//  MovieMatcher
//
//  Created by DavidR on 28/09/2021.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name:"MovieMatcher")
        
        container.loadPersistentStores{(storeDescription, error) in
            if let error = error as NSError?{
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}
