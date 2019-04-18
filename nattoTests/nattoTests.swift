//
//  nattoTests.swift
//  nattoTests
//
//  Created by 佐川晴海 on 2019/04/17.
//  Copyright © 2019 佐川　晴海. All rights reserved.
//

import XCTest
@testable import natto

class nattoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMixModel(){
        let model = MixModel()
        
        // normal
        var ohashiPos = model.updateOhashiPosition(touchPosX: 100, touchPosY: 100, ohashiRadius: 50)
        XCTAssertEqual(ohashiPos, ObjectPosition(x: 100, y: 50))
        
        // - value
        ohashiPos = model.updateOhashiPosition(touchPosX: 100, touchPosY: 0, ohashiRadius: 100)
        XCTAssertEqual(ohashiPos, ObjectPosition(x: 100, y: -100))
        
        // Zero radius
        ohashiPos = model.updateOhashiPosition(touchPosX: 100, touchPosY: 100, ohashiRadius: 0)
        XCTAssertEqual(ohashiPos, ObjectPosition(x: 100, y: 100))
        
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
