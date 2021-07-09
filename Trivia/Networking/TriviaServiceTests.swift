//
//  TriviaServiceTests.swift
//  TriviaTests
//
//  Created by Josh R on 7/8/21.
//

import SwiftyJSON
import XCTest

@testable import Trivia

class TriviaServiceTests: XCTestCase {
    
    var subject: TriviaService!
    
    override func setUp() {
        super.setUp()
        
        subject = TriviaService()
    }
    
    override func tearDown() {
        super.tearDown()
        
        subject = nil
    }
    
    func testJsonParseMethod() {
        let jsonFilePath = Bundle.main.path(forResource: "triviaItem", ofType: "json")
        XCTAssertNotNil(jsonFilePath)
        
        let data = try! Data(contentsOf: URL(fileURLWithPath: jsonFilePath!), options: .alwaysMapped)
        let jsonObj = try! JSON(data: data)
        var parsedTriviaItem = subject.parseTrivia(json: jsonObj)
        XCTAssertNotNil(parsedTriviaItem)
        
        var expectedTriviaItem = TriviaItem(difficulty: .easy,
                                            question: "In The Simpsons, which war did Seymour Skinner serve in the USA Army as a Green Beret?",
                                            correctAnswer: "Vietnam War",
                                            incorrectAnswers: [
                                                "World War 2",
                                                "World War 1",
                                                "Cold War"
                                            ])
        expectedTriviaItem.combineAllAnswers()
        
        //sort possible answers
        // The combineAllAnswers method shuffles the answers.  If order to check equality,
        // we need to sort the allPossibleAnswers array.
        parsedTriviaItem?.allPossibleAnswers.sort()
        expectedTriviaItem.allPossibleAnswers.sort()
        
        XCTAssertEqual(parsedTriviaItem, expectedTriviaItem)
    }
}
