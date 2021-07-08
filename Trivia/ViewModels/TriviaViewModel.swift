//
//  TriviaViewModel.swift
//  Trivia
//
//  Created by Josh R on 7/4/21.
//

import Combine
import RealmSwift
import SwiftyJSON

class TriviaViewModel: ObservableObject {
    @Published var triviaItem: TriviaItem?
    @Published var totalPointsEarned: Int?
    
    private var realm: Realm?
    private var realmNotification: NotificationToken?
    
    private var user: Results<User>?
    
    private let triviaNetworkManager: TriviaNetworkManager
    
    init(realm: Realm? = RealmManager.shared.realm,
         triviaNetworkManager: TriviaNetworkManager = TriviaNetworkManager()
    ) {
        self.realm = realm
        self.triviaNetworkManager = triviaNetworkManager
        fetchNewQuestion()
        
        user = realm?.objects(User.self)
        
        realmNotification = user?.observe { [weak self] changes in
            switch changes {
            case .initial:
                self?.totalPointsEarned = self?.user?.first?.pointsEarned ?? 0
            case .update:
                self?.totalPointsEarned = self?.user?.first?.pointsEarned ?? 0
            case .error(let error):
                print("Error observing user: \(error.localizedDescription)")
            }
        }
    }
    
    deinit {
        realmNotification?.invalidate()
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
    
    func selected(answer: String) {
        guard let realm = realm, let triviaItem = triviaItem else { return }
        let didChoseCorrectAnswer = answer == triviaItem.correctAnswer
        
        do {
            try realm.write {
                let user = User.getUser(in: realm)
                if didChoseCorrectAnswer {
                    user.numberOfCorrectAnswers += 1
                    user.pointsEarned += triviaItem.points
                } else {
                    user.pointsEarned -= triviaItem.points
                }
                user.numberOfQuestionsAsked += 1
                user.pointsPossible += triviaItem.points
            }
        } catch {
            print("Relam write error: \(error.localizedDescription)")
        }
    }
}
