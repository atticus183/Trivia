//
//  FormattersTests.swift
//  TriviaTests
//
//  Created by Josh R on 7/7/21.
//

import XCTest

@testable import Trivia

class FormattersTests: XCTestCase {
    
    //Not using since percentage is a type computed property.  Intialization not needed.
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRoundDownNumberPercent() {
        let fourtyFivePercent: Double = 0.4554
        let nsNumber = NSNumber(value: fourtyFivePercent)
        let formatted = Formatters.percentage.string(from: nsNumber)
        
        let expected = "45.5%"
        
        XCTAssertNotNil(formatted)
        XCTAssertEqual(expected, formatted)
    }
    
    func testRoundUpNumberPercent() {
        let fourtyFivePercent: Double = 0.4555
        let nsNumber = NSNumber(value: fourtyFivePercent)
        let formatted = Formatters.percentage.string(from: nsNumber)
        
        let expected = "45.6%"
        
        XCTAssertNotNil(formatted)
        XCTAssertEqual(expected, formatted)
    }
    
    func testWholeNumberPercent() {
        let fourtyPercent: Double = 0.400
        let nsNumber = NSNumber(value: fourtyPercent)
        let formatted = Formatters.percentage.string(from: nsNumber)
        
        let expected = "40%"
        
        XCTAssertNotNil(formatted)
        XCTAssertEqual(expected, formatted)
    }
}
