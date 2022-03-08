//
//  ApiDataTests.swift
//  CoreDataAssignmentTests
//
//  Created by Apple on 07/03/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import XCTest
@testable import CoreDataAssignment
@testable import ReachabilitySwift

class ApiDataTests: XCTestCase {

 func testNetworkConnected() {
    let networkStatus = Reachability()?.isReachable
    XCTAssertTrue(networkStatus!)
}

func testNetworkDisconnected() {
    let networkStatus = Reachability()?.isReachable
    XCTAssertFalse(networkStatus!)
}
 func testAPIWorking() {
   let expectation = self.expectation(description: "url_return_valid_response")
   NetworkOperation().postRequest(methodName: StringLiterals.jsonUrl) { (response) in
    XCTAssertNotNil(response)
    expectation.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
}
func testJSONMapping() throws {
    NetworkOperation().postRequest(methodName: StringLiterals.jsonUrl) { (response) in
    guard let newResponse = response as? String
    else {
          XCTFail("Failing Response : Incorrect format")
           return
          }
          let jsonData = Data((newResponse).utf8)
          let jsonDecoder = JSONDecoder()
      do {
           let data = try jsonDecoder.decode(DataList.self, from: jsonData)
            XCTAssertEqual(data.timezone, "America/Chicago")
          } catch {
        }
     }
    }
}
