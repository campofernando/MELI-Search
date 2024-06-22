//
//  WhenSavesAnItem.swift
//  MELI SearchTests
//
//  Created by Fernando Campo Garcia on 21/06/24.
//

import XCTest
@testable import MELI_Search

final class WhenSavesAnItem: XCTestCase {

    var persistenceController: PersistenceController!
    var dbService: MeliSearchDataService!
    
    override func setUpWithError() throws {
        persistenceController = PersistenceController(inMemory: true)
        dbService = MeliSearchDataService(context: persistenceController.container.viewContext)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveNewItem() throws {
        do {
            guard let item = try MeliItem.getMocks().first else {
                XCTFail("The array is empty")
                return
            }
            try dbService.saveItem(item)
            guard let itemObject = try dbService.fetchItem(withId: item.itemId) else {
                XCTFail("Object not in the database")
                return
            }
            XCTAssertEqual(itemObject.itemId, item.itemId)
            XCTAssertFalse(itemObject.attributes.isEmpty)
            XCTAssertNotNil(itemObject.installments)
            XCTAssertEqual(itemObject.installments?.currencyId, item.installments?.currencyId)
            XCTAssertNotNil(itemObject.shipping)
            XCTAssertEqual(itemObject.shipping?.freeShipping, item.shipping?.freeShipping)
        } catch {
            XCTFail("An error occured while fetching API: \(error.localizedDescription)")
        }
    }
    
    func testSaveExistingItem() throws {
        do {
            let items = try MeliItem.getMocks()
            guard let firstItem = items.first, let lastItem = items.last else {
                XCTFail("The array is empty")
                return
            }
            try dbService.saveItem(firstItem)
            guard let itemObject = try dbService.fetchItem(withId: firstItem.itemId) else {
                XCTFail("Object not in the database")
                return
            }
            XCTAssertEqual(itemObject.itemId, firstItem.itemId)
            
            let newItem = lastItem.getMock(withId: firstItem.itemId)
            try dbService.saveItem(newItem)
            guard let itemObject = try dbService.fetchItem(withId: newItem.itemId) else {
                XCTFail("Object not in the database")
                return
            }
            XCTAssertEqual(itemObject.permalink, lastItem.permalink)
            XCTAssertNotEqual(itemObject.permalink, firstItem.permalink)
            XCTAssertFalse(itemObject.attributes.isEmpty)
            XCTAssertNotNil(itemObject.installments)
            XCTAssertEqual(itemObject.installments?.currencyId, lastItem.installments?.currencyId)
            XCTAssertNotNil(itemObject.shipping)
            XCTAssertEqual(itemObject.shipping?.freeShipping, lastItem.shipping?.freeShipping)
        } catch {
            XCTFail("An error occured while fetching API: \(error.localizedDescription)")
        }
    }
    
    func testSaveAllItems() throws {
        do {
            let items = try MeliItem.getMocks()
            XCTAssertFalse(items.isEmpty)
            
            try dbService.saveItems(items)
            let itemObjects = try dbService.fetchItems()
            
            XCTAssertEqual(itemObjects.count, items.count)
        } catch {
            XCTFail("An error occured while fetching API: \(error.localizedDescription)")
        }
    }
}
