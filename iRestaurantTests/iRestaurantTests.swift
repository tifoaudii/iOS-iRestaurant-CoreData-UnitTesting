//
//  iRestaurantTests.swift
//  iRestaurantTests
//
//  Created by Tifo Audi Alif Putra on 26/12/20.
//

import XCTest
@testable import iRestaurant

class iRestaurantTests: XCTestCase {
    
    var sut: RestoDataStore!
    var coreDataStack: TestCoreDataStack!

    override func setUpWithError() throws {
        coreDataStack = TestCoreDataStack()
        sut = RestoDataStore(
            context: coreDataStack.viewContext,
            coreDataStack: coreDataStack
        )
        
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        coreDataStack = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testAddMenuModel() {
        let newMenu = sut.addMenu(name: "Meatball", desc: "Indonesian favorite food", price: 10000)
        XCTAssertNotNil(newMenu, "menu should not nil")
        XCTAssert(newMenu.name == "Meatball", "menu name should Meatball")
        XCTAssert(newMenu.desc == "Indonesian favorite food")
        XCTAssert(newMenu.price == 10000)
    }
    
    func testBackgroundContextToSaveMenu() {
        let backgroundContext = coreDataStack.backgroundContext()
        sut = RestoDataStore(
            context: backgroundContext,
            coreDataStack: coreDataStack
        )
        
        expectation(forNotification: .NSManagedObjectContextDidSave, object: backgroundContext)
        
        backgroundContext.perform {
            let newMenu = self.sut.addMenu(
                name: "Satay",
                desc: "Indonesian Food",
                price: 20000
            )
            
            XCTAssertNotNil(newMenu, "new menu value should not nil")
        }
        
        waitForExpectations(timeout: 2.0) { (error: Error?) in
            XCTAssertNil(error, "Error should not exist")
        }
    }
    
    func testFetchMenu() {
        let firstMenu = sut.addMenu(name: "Hotdog", desc: "Delicious", price: 10000)
        sut.fetchMenu { (menu: [Menu]) in
            XCTAssertNotNil(menu, "menu should not nil")
            XCTAssert(!menu.isEmpty, "menu should not empty")
            XCTAssert(menu.first == firstMenu, "Menu should be same")
        }
    }
    
    func testUpdateMenu() {
        let initialMenu = sut.addMenu(name: "Burger", desc: "Nice", price: 13000)
        
        XCTAssertNotNil(initialMenu, "menu should not nil")
        XCTAssert(initialMenu.name == "Burger", "menu name should Burger")
        XCTAssert(initialMenu.desc == "Nice", "menu desc should Nice")
        XCTAssert(initialMenu.price == 13000, "menu price should 13000")
        
        initialMenu.name = "Steak"
        initialMenu.desc = "Expensive"
        initialMenu.price = 25000
        
        let updatedMenu = sut.updateMenu(menu: initialMenu)
        XCTAssertNotNil(updatedMenu, "menu should not nil")
        XCTAssert(updatedMenu.name == "Steak", "menu name should Steak")
        XCTAssert(updatedMenu.desc == "Expensive", "menu desc should Expensive")
        XCTAssert(updatedMenu.price == 25000, "menu price should 25000")
    }
    
    func testDeleteMenu() {
        let newMenu = sut.addMenu(name: "Kebab", desc: "Turkish Food", price: 45000)
        
        XCTAssertNotNil(newMenu, "menu should not nil")
        XCTAssert(newMenu.name == "Kebab", "menu name should Kebab")
        XCTAssert(newMenu.desc == "Turkish Food", "menu desc should Turkish Food")
        XCTAssert(newMenu.price == 45000, "menu price should 45000")
        
        sut.fetchMenu { (menu: [Menu]) in
            XCTAssert(!menu.isEmpty, "menu should not empty")
        }
        
        sut.deleteMenu(menu: newMenu)
        sut.fetchMenu { (menu: [Menu]) in
            XCTAssert(menu.isEmpty, "menu should empty")
        }
    }
}
