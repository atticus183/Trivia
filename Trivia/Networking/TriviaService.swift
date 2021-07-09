//
//  TriviaNetworkManager.swift
//  Trivia
//
//  Created by Josh R on 7/4/21.
//

import Alamofire
import Combine
import Foundation
import SwiftyJSON

protocol TriviaServiceProtocol {
    func getRandomQuestion(completion: @escaping (Result<TriviaItem?, Error>) -> Void)
    func parseTrivia(json: JSON) -> TriviaItem?
}

struct Parameters: Encodable {
    var amount: Int
    var category: String?
    var difficulty: String?
    var type: String?
}

class TriviaService: TriviaServiceProtocol {
    let baseURL = "https://opentdb.com/api.php"
    
    let oneRandomQuestionParameters = Parameters(amount: 1)
    
    func getRandomQuestion(completion: @escaping (Result<TriviaItem?, Error>) -> Void) {
        AF.request(baseURL,
                   method: .get,
                   parameters: oneRandomQuestionParameters,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil).responseData { [weak self] response in
                    switch response.result {
                    case .success(let data):
                        let json = try! JSON(data: data)
                        let triviaItem = self?.parseTrivia(json: json)
                        completion(.success(triviaItem))
                    case let .failure(error):
                        print(error)
                        completion(.failure(error))
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
