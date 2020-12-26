//
//  RestoDataStore.swift
//  iRestaurant
//
//  Created by Tifo Audi Alif Putra on 26/12/20.
//

import Foundation
import CoreData

class RestoDataStore: RestoServiceProtocol {
    
    private let context: NSManagedObjectContext
    private let coreDataStack: CoreDataStack
    
    init(context: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.context = context
        self.coreDataStack = coreDataStack
    }
    
    func fetchMenu(completion: @escaping ([Menu]) -> Void) {
        let fetchMenuRequest: NSFetchRequest<Menu> = Menu.fetchRequest()
        do {
            let menu = try context.fetch(fetchMenuRequest)
            completion(menu)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func addMenu(name: String, desc: String, price: Double) {
        let newMenu = Menu(context: context)
        newMenu.id = UUID()
        newMenu.name = name
        newMenu.desc = desc
        newMenu.price = price
        
        coreDataStack.save(context)
    }
    
    func updateMenu(menu: Menu) {
        coreDataStack.save(context)
    }
    
    func deleteMenu(menu: Menu) {
        context.delete(menu)
        coreDataStack.save(context)
    }
}
