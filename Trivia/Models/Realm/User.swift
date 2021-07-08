//
//  User.swift
//  Trivia
//
//  Created by Josh R on 7/5/21.
//

import Foundation
import RealmSwift

@objcMembers
class User: Object {
    dynamic var pointsEarned: Int = 0
    dynamic var pointsPossible: Int = 0
    dynamic var numberOfCorrectAnswers: Int = 0
    dynamic var numberOfQuestionsAsked: Int = 0
}

extension User {
    // MARK: Computed Properties
    var winPercentage: String {
        let winRate: Double = Double(numberOfCorrectAnswers) / Double(numberOfQuestionsAsked)
        let nsNumber = NSNumber(value: winRate)
        return Formatters.percentage.string(from: nsNumber) ?? "0.0%"
    }
    
    // MARK: Methods
    
    static func createUserOnLaunch(in realm: Realm? = RealmService.shared.realm) {
        guard let realm = realm else { return }
        let user = realm.objects(User.self).first
        
        if user == nil {
            do {
                try realm.write {
                    let newUser = User()
                    realm.add(newUser)
                }
            } catch {
                print("Error creating user: \(error.localizedDescription)")
            }
        }
    }
    
    static func getUser(in realm: Realm) -> User {
        let retrievedUser = realm.objects(User.self).first!
        return retrievedUser
    }
}
