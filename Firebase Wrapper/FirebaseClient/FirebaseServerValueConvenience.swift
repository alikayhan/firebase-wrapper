//
//  FirebaseServerValueConvenience.swift
//  Marketolist
//
//  Created by Ali Kayhan on 10/10/2016.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import Foundation
import Firebase

// MARK: - FirebaseClient (Convenient Resource Methods - ServerValue)

extension FirebaseClient {
    
    var serverTimestamp: [NSObject: AnyObject] {
        get {
            return FIRServerValue.timestamp()
        }
    }
}
