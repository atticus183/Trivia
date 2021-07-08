//
//  ProfileViewModel.swift
//  Trivia
//
//  Created by Josh R on 7/6/21.
//

import Combine
import Foundation
import RealmSwift

class ProfileViewModel: ObservableObject {
    @Published var numberOfCorrectAnswers: Int?
    @Published var numberOfQuestionsAsked: Int?
    @Published var winPercentage: String?
    
    private var realm: Realm?
    private var realmNotification: NotificationToken?
    
    private var users: Results<User>?
    
    init(realm: Realm? = RealmService.shared.realm) {
        self.realm = realm
        
        users = realm?.objects(User.self)
        
        realmNotification = users?.observe { [weak self] changes in
            guard let user = self?.users?.first else { return }
            switch changes {
            case .initial:
                self?.winPercentage = user.winPercentage
                self?.numberOfCorrectAnswers = user.numberOfCorrectAnswers
                self?.numberOfQuestionsAsked = user.numberOfQuestionsAsked
            case .update:
                self?.winPercentage = user.winPercentage
                self?.numberOfCorrectAnswers = user.numberOfCorrectAnswers
                self?.numberOfQuestionsAsked = user.numberOfQuestionsAsked
            case .error(let error):
                print("Error observing user: \(error.localizedDescription)")
            }
        }
    }
    
    deinit {
        realmNotification?.invalidate()
    }
}
