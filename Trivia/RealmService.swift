//
//  RealmManager.swift
//  Trivia
//
//  Created by Josh R on 7/5/21.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    var config: Realm.Configuration { get set }
    var realm: Realm? { get set }
}

class RealmService: RealmServiceProtocol {
    
    static let shared = RealmService()
    
    private init() {}
    
    // MARK: Realm Configuration
    
    lazy var config: Realm.Configuration = {
        let config = Realm.Configuration(inMemoryIdentifier: nil,
                                         syncConfiguration: nil,
                                         encryptionKey: nil,
                                         readOnly: false,
                                         schemaVersion: 1,
                                         migrationBlock: nil,
                                         deleteRealmIfMigrationNeeded: true,
                                         shouldCompactOnLaunch: nil,
                                         objectTypes: nil)
        return config
    }()
    
    // MARK: Realm
    
    lazy var realm: Realm? = {
        do {
            let realm = try Realm(configuration: config)
            print("REALM FILE LOCAITON: \(String(describing: realm.configuration.fileURL))")
            return realm
        } catch {
            print("ERROR RETRIEVING REALM: \(error.localizedDescription)")
        }
        
        return nil
    }()
}

class MockRealmService: RealmServiceProtocol {
    lazy var config: Realm.Configuration = {
        let config = Realm.Configuration(inMemoryIdentifier: UUID().uuidString,
                                         syncConfiguration: nil,
                                         encryptionKey: nil,
                                         readOnly: false,
                                         schemaVersion: 1,
                                         migrationBlock: nil,
                                         deleteRealmIfMigrationNeeded: true,
                                         shouldCompactOnLaunch: nil,
                                         objectTypes: nil)
        return config
    }()
    
    // MARK: Realm
    
    lazy var realm: Realm? = {
        do {
            let realm = try Realm(configuration: config)
            return realm
        } catch {
            print("ERROR RETRIEVING REALM: \(error.localizedDescription)")
        }
        
        return nil
    }()
}
