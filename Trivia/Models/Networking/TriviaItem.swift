//
//  Question.swift
//  Trivia
//
//  Created by Josh R on 7/4/21.
//

import Foundation

struct TriviaItem {
    let difficulty: Difficulty
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    var allPossibleAnswers = [String]()
}

extension TriviaItem {
    mutating func combineAllAnswers() {
        let allAnswers = incorrectAnswers + [correctAnswer]
        allPossibleAnswers = allAnswers.shuffled()
    }
    
    var indexOfCorrectAnswer: Int {
        allPossibleAnswers.firstIndex(of: correctAnswer)!
    }
    
    enum Difficulty: String {
        case easy
        case medium
        case hard
    }
    
    var points: Int {
        switch difficulty {
        case .easy:
            return 100
        case .medium:
            return 200
        case .hard:
            return 300
        }
    }
}

