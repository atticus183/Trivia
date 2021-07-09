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
    
    private let triviaService: TriviaServiceProtocol
    
    private var user: Results<User>?
    
    //MARK : Initialization
    
    init(realm: Realm? = RealmService.shared.realm,
         triviaService: TriviaServiceProtocol = TriviaService()
    ) {
        self.realm = realm
        self.triviaService = triviaService
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
        triviaService.getRandomQuestion { [weak self] result in
            switch result {
            case .success(let triviaItem):
                self?.triviaItem = triviaItem
            case .failure(let error):
                print("Error from view model: \(error)")
            }
        }
    }
    
    //MARK : Methods
    

    
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
