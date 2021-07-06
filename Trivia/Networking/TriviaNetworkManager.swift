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

struct Parameters: Encodable {
    var amount: Int
    var category: String?
    var difficulty: String?
    var type: String?
}

class TriviaNetworkManager {
    let baseURL = "https://opentdb.com/api.php"
    
    let oneRandomQuestionParameters = Parameters(amount: 1)
    
    func getRandomQuestion(completion: @escaping (Result<JSON, Error>) -> Void) {
        AF.request(baseURL,
                   method: .get,
                   parameters: oneRandomQuestionParameters,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil).responseData { response in
                    switch response.result {
                    case .success(let data):
                        let json = try! JSON(data: data)
                        completion(.success(json))
                    case let .failure(error):
                        print(error)
                        completion(.failure(error))
                    }
                   }
    }
}
