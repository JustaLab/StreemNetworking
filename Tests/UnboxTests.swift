//
//  UnboxTests.swift
//  Nikka
//
//  Created by Emilien on 10/21/16.
//  Copyright © 2016 Emilien Stremsdoerfer. All rights reserved.
//

import XCTest
@testable import Nikka
@testable import Unbox

class UnboxTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testDeserializeObject() {
        struct TestIP: Unboxable {
            let ip: String

            init(unboxer: Unboxer) throws {
                self.ip = try unboxer.unbox(key: "origin")
            }
        }

        let expectation = self.expectation(description: "GET request should succeed")

        let provider = TestProvider()
        provider.request(.ip).responseObject { (response: Response<TestIP>) in
            expectation.fulfill()
            XCTAssertNil(response.result.error)
            XCTAssertNotNil(response.result.value)
            XCTAssertNotEqual(response.result.value?.ip, "")
        }

        waitForExpectations(timeout: timeout, handler: nil)
    }

    func testDeserializeObjectError() {
        struct TestIP: Unboxable {
            let ip: String

            init(unboxer: Unboxer) throws {
                self.ip = try unboxer.unbox(key: "blah")
            }
        }

        let expectation = self.expectation(description: "GET request should fail")

        let provider = TestProvider()
        provider.request(.ip).responseObject { (response: Response<TestIP>) in
            expectation.fulfill()
            XCTAssertNil(response.result.value)
            XCTAssertTrue((response.result.error?.isEqual(err: NikkaNetworkingError.jsonMapping("")))!)
        }

        waitForExpectations(timeout: timeout, handler: nil)
    }

}
