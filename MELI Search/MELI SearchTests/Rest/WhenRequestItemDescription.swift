//
//  WhenRequestItemDescription.swift
//  MELI SearchTests
//
//  Created by Fernando Campo Garcia on 23/06/24.
//

import XCTest
@testable import MELI_Search

final class WhenRequestItemDescription: XCTestCase {

    var httpClient: HttpClient!
    var itemsService: MeliItemsService!
    var request: URLRequest!
    let itemId = "MLB2040426998"
    
    override func setUpWithError() throws {
        httpClient = URLSession.shared
        let searchItemsURL = MeliBRApiHelper.getItemDescriptionURL(itemId: itemId)!
        request = URLRequest(url: searchItemsURL)
        itemsService = MeliItemsService(httpClient: httpClient)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestItemDescription() throws {
        let expectation = self.expectation(description: "Items fetched successfully from category")
        itemsService.getItemDescription(itemId: itemId) { result in
            switch result {
            case .success(let description):
                XCTAssertFalse(description.plainText?.isEmpty ?? true)
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
