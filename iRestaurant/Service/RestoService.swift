//
//  RestoService.swift
//  iRestaurant
//
//  Created by Tifo Audi Alif Putra on 26/12/20.
//

import Foundation

protocol RestoServiceProtocol {
    func fetchMenu(completion: @escaping (_ menu: [Menu]) -> Void)
    func addMenu(name: String, desc: String, price: Double)
    func updateMenu(menu: Menu)
    func deleteMenu(menu: Menu)
}

class RestoService {
    
    private let dataStore: RestoServiceProtocol
    
    init(dataStore: RestoServiceProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchMenu(completion: @escaping (_ menu: [Menu]) -> Void) {
        dataStore.fetchMenu { (menu: [Menu]) in
            DispatchQueue.main.async {
                completion(menu)
            }
        }
    }
    
    func addMenu(name: String, desc: String, price: Double) {
        dataStore.addMenu(name: name, desc: desc, price: price)
    }
    
    func updateMenu(menu: Menu) {
        dataStore.updateMenu(menu: menu)
    }
    
    func deleteMenu(menu: Menu) {
        dataStore.deleteMenu(menu: menu)
    }
}
