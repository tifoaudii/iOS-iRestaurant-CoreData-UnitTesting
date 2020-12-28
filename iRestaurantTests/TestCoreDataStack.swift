//
//  TestCoreDataStack.swift
//  iRestaurantTests
//
//  Created by Tifo Audi Alif Putra on 28/12/20.
//

@testable import iRestaurant
import CoreData

class TestCoreDataStack: CoreDataStack {

    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let testPersistentContainer = NSPersistentContainer(name: CoreDataStack.modelName)
        testPersistentContainer.persistentStoreDescriptions = [persistentStoreDescription]
        testPersistentContainer.loadPersistentStores { (_, error: Error?) in
            if let _ = error {
                fatalError()
            }
        }
        
        persistentContainer = testPersistentContainer
    }
    
}
