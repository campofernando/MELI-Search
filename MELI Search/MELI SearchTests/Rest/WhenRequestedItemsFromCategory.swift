//
//  WhenRequestedItemsFromCategory.swift
//  MELI SearchTests
//
//  Created by Fernando Campo Garcia on 17/06/24.
//

import XCTest
@testable import MELI_Search

final class WhenRequestedItemsFromCategory: XCTestCase {

    var httpClient: HttpClient!
    var itemsService: MeliItemsService!
    var request: URLRequest!
    let categoryId = "MLB1367"
    
    override func setUpWithError() throws {
        httpClient = URLSession.shared
        let categoriesURL = MeliBRApiHelper.getCategorySearchURL(withCategoryId: categoryId)!
        request = URLRequest(url: categoriesURL)
        itemsService = MeliItemsService(httpClient: httpClient)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestItemsOfCategorySuccess() throws {
        let expectation = self.expectation(description: "Items fetched successfully from category")
        httpClient.performRequest(request: request) { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success.data)
                XCTAssertEqual(success.httpResponse.statusCode, 200)
            case .failure(let failure):
                XCTFail("An error occured while fetching API: \(failure.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }

    func testFetchItemsOfCategorySuccess() throws {
        let expectation = self.expectation(description: "Items fetched successfully from category")
        itemsService.getItemsByCategory(withCategoryId: categoryId) { result in
            switch result {
            case .success(let items):
                XCTAssertFalse(items.isEmpty)
                print(items)
            case .failure(let failure):
                XCTFail("An error occured while fetching API: \(failure.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
