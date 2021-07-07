//
//  RealmManager.swift
//  Trivia
//
//  Created by Josh R on 7/5/21.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    let isTesting: Bool
    
    private init(isTesting: Bool = false) {
        self.isTesting = isTesting
    }
    
    // MARK: Realm Configuration
    
    lazy var config: Realm.Configuration = {
        let config = Realm.Configuration(inMemoryIdentifier: isTesting ? UUID().uuidString : nil,
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
