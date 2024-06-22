//
//  RequestItemsAndSave.swift
//  MELI SearchTests
//
//  Created by Fernando Campo Garcia on 22/06/24.
//

import XCTest
@testable import MELI_Search

final class RequestItemsAndSave: XCTestCase {

    var persistenceController: PersistenceController!
    var dbService: MeliSearchDataService!
    var httpClient: HttpClient!
    var itemsService: MeliItemsService!
    var request: URLRequest!
    let searchText = "Motorola%20G6"
    
    override func setUpWithError() throws {
        persistenceController = PersistenceController(inMemory: true)
        dbService = MeliSearchDataService(context: persistenceController.container.viewContext)
        httpClient = URLSession.shared
        let searchItemsURL = MeliBRApiHelper.getItemsSearchURL(withText: searchText)!
        request = URLRequest(url: searchItemsURL)
        itemsService = MeliItemsService(httpClient: httpClient)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetItemsAndSave() throws {
        let expectation = self.expectation(description: "Items fetched successfully from category")
        itemsService.getItemsBySearch(searchText: searchText) { result in
            switch result {
            case .success(let items):
                XCTAssertFalse(items.isEmpty)
                do {
                    try self.dbService.saveItems(items)
                    let itemObjects = try self.dbService.fetchItems()
                    
                    XCTAssertEqual(itemObjects.count, items.count)
                } catch {
                    XCTFail("An error occured while fetching API: \(error.localizedDescription)")
                }
            case .failure(let failure):
                XCTFail("An error occured while fetching API: \(failure.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
