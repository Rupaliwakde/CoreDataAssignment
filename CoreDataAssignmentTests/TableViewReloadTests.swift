//
//  TableViewReloadTests.swift
//  CoreDataAssignmentTests
//
//  Created by Apple on 08/03/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import XCTest
@testable import CoreDataAssignment

class TableViewReloadTests: XCTestCase {
var viewControllerUnderTest: WeatherDataListVC!

override func setUp() {
            super.setUp()
            self.viewControllerUnderTest = WeatherDataListVC()
            self.viewControllerUnderTest.loadView()
            self.viewControllerUnderTest.viewDidLoad()
}
override func tearDown() {
            // for clearing all the states.
            super.tearDown()
}
func testHasATableView() {
            XCTAssertNotNil(viewControllerUnderTest.tableView)
}

func testTableViewCellHasReuseIdentifier() {
          let cell = viewControllerUnderTest.tableView.dequeueReusableCell(
            withIdentifier: "cell", for: IndexPath(row: 0, section: 0)) as? CustomTableViewCell
            let actualReuseIdentifer = cell?.reuseIdentifier
            let expectedReuseIdentifier = "cell"
            XCTAssertEqual(actualReuseIdentifer,
                           expectedReuseIdentifier)
 }

}
