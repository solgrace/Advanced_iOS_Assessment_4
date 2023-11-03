//
//  PersistenceController.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 25/10/23.
//

import CoreData // Import the CoreData framework
import Foundation

// This struct manages the persistent data storage
struct PersistenceController {
    
    // Singleton instance to allow global access to this controller
    static let shared = PersistenceController()
    
    // This is a preview instance using in-memory storage
    static var preview: PersistenceController = {
        
        let result = PersistenceController() // Create an instance of the Persistence controller with in-memory storage
        // The "inMemory" parameter indicates that the Core Data sTACK SHOULD USE AN IN-MEMORY STORE, MEANING THE DATA IS NOT persisted on disk but kept in memory
        
        let viewContext = result.container.viewContext
        
        for _ in 0..<10 {
            // Create 10 new Itinerary Activity objects
            let newItem = Expense(context: viewContext)
        }
        
        do {
            try viewContext.save()
        }
        catch {
            
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result // Return the instance for the preview
    }() // The declared static property named "preview" uses a closure to provide a custom initializer for the "preview" property
    
    let container: NSPersistentContainer // this is the Main persistent container
    
    init(inMemory: Bool = false) {

        container = NSPersistentContainer(name: "Expenses") // Initliaze the persistence container with the Data model name

        if (inMemory) {

            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            // Handle error during store loading
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true // Automatically merge changes from parent context
    }
        
//    init() {
//        container = NSPersistentContainer(name: "Expenses")
//        if let storeDescription = container.persistentStoreDescriptions.first {
//            storeDescription.setOption("group.ios_advanced_assignment_4.sharedcoredata" as NSObject, forKey: "Expense")
//        }
//        container.loadPersistentStores { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Error loading persistent stores: \(error), \(error.userInfo)")
//            } else {
//                print("Persistent stores loaded successfully.")
//            }
//        }
//        container.viewContext.automaticallyMergesChangesFromParent = true
//    }
    
}

