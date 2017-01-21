//
//  FirebaseClient.swift
//  Marketolist
//
//  Created by Ali Kayhan on 29/08/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import Foundation
import Firebase

class FirebaseClient: NSObject {
    
    var refHandle: FIRDatabaseHandle!
    
    // MARK: - Initializers
    override init() {
        super.init()
    }
    
    // MARK: - Shared Instance as Singleton
    class func sharedInstance() -> FirebaseClient {
        struct Singleton {
            static var sharedInstance = FirebaseClient()
        }
        return Singleton.sharedInstance
    }
}
