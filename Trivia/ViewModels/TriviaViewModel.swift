//
//  TriviaViewModel.swift
//  Trivia
//
//  Created by Josh R on 7/4/21.
//

import Combine
import SwiftyJSON

class TriviaViewModel: ObservableObject {
    @Published var triviaItem: TriviaItem?
    
    private let triviaNetworkManager: TriviaNetworkManager
    
    init(triviaNetworkManager: TriviaNetworkManager = TriviaNetworkManager()) {
        self.triviaNetworkManager = triviaNetworkManager
        fetchNewQuestion()
    }
    
    func fetchNewQuestion() {
        triviaNetworkManager.getRandomQuestion { [weak self] result in
            switch result {
            case .success(let json):
                print("\(json)")
                self?.triviaItem = self?.parseTrivia(json: json)
            case .failure(let error):
                print("Error from view model: \(error)")
            }
        }
    }
    
    func parseTrivia(json: JSON) -> TriviaItem? {
        guard let results = json["results"].array?.first else { return nil }
        let difficulty = results["difficulty"].stringValue
        let question = String(htmlEncodedString: results["question"].stringValue) ?? ""
        let correctAnswer = results["correct_answer"].stringValue
        let incorrectAnswers = results["incorrect_answers"].arrayValue.map { $0.stringValue }
        var retrievedQuestion = TriviaItem(difficulty: TriviaItem.Difficulty(rawValue: difficulty)!,
                                           question: question,
                                           correctAnswer: correctAnswer,
                                           incorrectAnswers: incorrectAnswers)
        retrievedQuestion.combineAllAnswers()
        return retrievedQuestion
    }
}
