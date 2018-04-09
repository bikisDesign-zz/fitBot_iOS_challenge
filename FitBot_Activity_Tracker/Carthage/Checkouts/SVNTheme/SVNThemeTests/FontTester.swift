//
//  FontTester.swift
//  SVNTheme
//
//  Created by Aaron Dean Bikis on 4/10/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import XCTest

@testable import SVNTheme

class FontTester: XCTestCase {
    var theme: SVNTheme!
    
    override func setUp() {
        super.setUp()
        theme = SVNTheme_DefaultDark()
        let foo = theme.textFieldw
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        theme = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
