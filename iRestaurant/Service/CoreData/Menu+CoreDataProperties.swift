//
//  Menu+CoreDataProperties.swift
//  iRestaurant
//
//  Created by Tifo Audi Alif Putra on 26/12/20.
//
//

import Foundation
import CoreData


extension Menu {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Menu> {
        return NSFetchRequest<Menu>(entityName: "Menu")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var price: Double

}

extension Menu : Identifiable {

}
