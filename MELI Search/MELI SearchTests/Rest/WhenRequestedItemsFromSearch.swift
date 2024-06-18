//
//  WhenRequestedItemsFromSearch.swift
//  MELI SearchTests
//
//  Created by Fernando Campo Garcia on 18/06/24.
//

import XCTest
@testable import MELI_Search

final class WhenRequestedItemsFromSearch: XCTestCase {

    var httpClient: HttpClient!
    var request: URLRequest!
    let searchText = "Motorola%20G6"
    
    override func setUpWithError() throws {
        httpClient = URLSession.shared
        let searchItemsURL = MeliBRApiHelper.getItemsSearchURL(withText: searchText)!
        request = URLRequest(url: searchItemsURL)
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
