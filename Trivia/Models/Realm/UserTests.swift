//
//  UserTests.swift
//  TriviaTests
//
//  Created by Josh R on 7/7/21.
//

import RealmSwift
import XCTest

@testable import Trivia

class UserTests: XCTestCase {
    
    var mockRealmService: RealmServiceProtocol!
    var realm: Realm!
    
    override func setUp() {
        super.setUp()
        
        mockRealmService = MockRealmService()
        realm = mockRealmService.realm
    }
    
    override func tearDown() {
        super.tearDown()
        
        realm = nil
    }
    
    func testGetUserFromRealm() {
        try! realm.write {
            let user = User()
            realm.add(user)
            
            XCTAssertNotNil(User.getUser(in: realm))
        }
    }
    
    func testRealmIsInMemory() {
        XCTAssertTrue(realm.configuration.inMemoryIdentifier != nil)
    }
    
    func testUserCanBeAddedToRealm() {
        try! realm.write {
            let user = User()
            realm.add(user)
            
            XCTAssertEqual(realm.objects(User.self).count, 1)
        }
    }
    
    func testWinPercentage() {
        try! realm.write {
            let user = User()
            user.numberOfCorrectAnswers = 1
            user.numberOfQuestionsAsked = 1
            
            XCTAssertEqual(user.winPercentage, "100%")
        }
        
        try! realm.write {
            let user = User()
            user.numberOfCorrectAnswers = 0
            user.numberOfQuestionsAsked = 1
            
            XCTAssertEqual(user.winPercentage, "0%")
        }
        
        try! realm.write {
            let user = User()
            user.numberOfCorrectAnswers = 2
            user.numberOfQuestionsAsked = 3
            
            XCTAssertEqual(user.winPercentage, "66.7%")
        }
    }
}
