//
//  TriviaItemTests.swift
//  TriviaTests
//
//  Created by Josh R on 7/7/21.
//

import XCTest

@testable import Trivia

class TriviaItemTests: XCTestCase {
    
    var subject: TriviaItem!
    
    override func setUp() {
        super.setUp()
        
        subject = TriviaItem(difficulty: .easy,
                             question: "What car company logo consists of four rings?",
                             correctAnswer: "Audi",
                             incorrectAnswers: ["BMW", "Mercedes", "VW"])
        subject.combineAllAnswers()
    }
    
    override func tearDown() {
        super.tearDown()
        
        subject = nil
    }
    
    func testCombineAllAnswers() {
        let expectation = ["BMW", "Mercedes", "VW", "Audi"]
        
        XCTAssertEqual(subject.allPossibleAnswers.sorted(), expectation.sorted())
    }
    
    func testCorrectPointsGivenWhenEasy() {
        let expected = 100
        XCTAssertEqual(expected, subject.points)
    }
    
    func testCorrectPointsGivenWhenHard() {
        subject = TriviaItem(difficulty: .hard,
                             question: "What car company logo consists of four rings?",
                             correctAnswer: "Audi",
                             incorrectAnswers: ["BMW", "Mercedes", "VW"])

        let expected = 300
        XCTAssertEqual(expected, subject.points)
    }
    
    func testCorrectPointsGivenWhenMedium() {
        subject = TriviaItem(difficulty: .medium,
                             question: "What car company logo consists of four rings?",
                             correctAnswer: "Audi",
                             incorrectAnswers: ["BMW", "Mercedes", "VW"])

        let expected = 200
        XCTAssertEqual(expected, subject.points)
    }
    
    func testIndexOfCorrectAnswer() {
        let expectation: Int = subject.allPossibleAnswers.firstIndex(of: subject.correctAnswer)!
        
        XCTAssertEqual(expectation, subject.indexOfCorrectAnswer)
    }
}
