//
//  FirebaseDatabaseConvenience.swift
//  Marketolist
//
//  Created by Ali Kayhan on 15/09/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

// MARK: - FirebaseClient (Convenient Resource Methods - Database)

extension FirebaseClient {
    
    // MARK: - Properties
    var database: FIRDatabase! {
        get {
            return FIRDatabase.database()
        }
    }
    
    var ref: FIRDatabaseReference! {
        // Since extensions may not contain stored properties but can add computer properties,
        // getter is overridden to assign a database reference to "ref" property
        get {
            return FIRDatabase.database().reference()
        }
    }
    
    // MARK: - Enable/Disable Disk Persistence
    func setPersistenceEnabled(enabled: Bool) {
        FIRDatabase.database().persistenceEnabled = enabled
    }
    
    // MARK: - Save Data
    func saveDataBySpecificID(pathString: String, data: [String:AnyObject]) {
        ref.child(pathString).setValue(data)
    }
    
    // MARK: - Save Datum
    func saveDatumBySpecificID(pathString: String, data: AnyObject) {
        ref.child(pathString).setValue(data)
    }
    
    // MARK: - Save Data By Child Auto ID
    func saveDataByAutoID(pathString: String, data: [String: AnyObject]) {
        ref.child(pathString).childByAutoId().setValue(data)
    }
    
    // MARK: - Update Child Values By Path String
    func updateChildValues(pathString: String, data: [String: AnyObject]) {
        ref.child(pathString).updateChildValues(data)
    }
    
    // MARK: - Update Child Values By Path:[Key:Value] Dictionary
    func updateChildValues(childUpdates: [String: AnyObject]) {
        ref.updateChildValues(childUpdates)
    }
    
    
    // MARK: - Read Data Once
    func readDataOnce(pathString: String, queryOrder: String? = nil, queryLimit: UInt? = nil, completionHandlerForReadDataOnce: (snapshot: FIRDataSnapshot) -> Void) {
        
        // TODO: - Find a better solution for this
        if queryOrder != nil && queryLimit != nil {
            ref.child(pathString).queryOrderedByChild(queryOrder!).queryLimitedToLast(queryLimit!).observeSingleEventOfType(.Value) { (snapshot: FIRDataSnapshot) in
                completionHandlerForReadDataOnce(snapshot: snapshot)
            }
        } else if queryOrder != nil {
            ref.child(pathString).queryOrderedByChild(queryOrder!).observeSingleEventOfType(.Value) { (snapshot: FIRDataSnapshot) in
                completionHandlerForReadDataOnce(snapshot: snapshot)
            }
        } else if queryLimit != nil {
            ref.child(pathString).queryLimitedToFirst(queryLimit!).observeSingleEventOfType(.Value) { (snapshot: FIRDataSnapshot) in
                completionHandlerForReadDataOnce(snapshot: snapshot)
            }
        } else {
            ref.child(pathString).observeSingleEventOfType(.Value) { (snapshot: FIRDataSnapshot) in
                completionHandlerForReadDataOnce(snapshot: snapshot)
            }
        }
    }
    
    // MARK: - Listen for All Data
    func listenForAllData(pathString: String, queryOrder: String? = nil, queryLimit: UInt? = nil, completionHandlerForListenForAllData: (snapshot: FIRDataSnapshot) -> Void) {
        
        // TODO: - Find a better solution for this
        if queryOrder != nil && queryLimit != nil {
            refHandle = ref.child(pathString).queryOrderedByChild(queryOrder!).queryLimitedToLast(queryLimit!).observeEventType(.Value) { (snapshot: FIRDataSnapshot) in
                completionHandlerForListenForAllData(snapshot: snapshot)
            }
        } else if queryOrder != nil {
            refHandle = ref.child(pathString).queryOrderedByChild(queryOrder!).observeEventType(.Value) { (snapshot: FIRDataSnapshot) in
                completionHandlerForListenForAllData(snapshot: snapshot)
            }
        } else if queryLimit != nil {
            refHandle = ref.child(pathString).queryLimitedToFirst(queryLimit!).observeEventType(.Value) { (snapshot: FIRDataSnapshot) in
                completionHandlerForListenForAllData(snapshot: snapshot)
            }
        } else {
            refHandle = ref.child(pathString).observeEventType(.Value) { (snapshot: FIRDataSnapshot) in
                completionHandlerForListenForAllData(snapshot: snapshot)
            }
        }
    }
    
    // MARK: - Listen for Added Data
    func listenForAddedData(pathString: String, queryOrder: String? = nil, queryLimit: UInt? = nil, completionHandlerForListenForAddedData: (snapshot: FIRDataSnapshot) -> Void) {
        
        // TODO: - Find a better solution for this
        if queryOrder != nil && queryLimit != nil {
            refHandle = ref.child(pathString).queryOrderedByChild(queryOrder!).queryLimitedToLast(queryLimit!).observeEventType(.Value) { (snapshot: FIRDataSnapshot) in
                completionHandlerForListenForAddedData(snapshot: snapshot)
            }
        } else if queryOrder != nil {
            refHandle = ref.child(pathString).queryOrderedByChild(queryOrder!).observeEventType(.ChildAdded) { (snapshot: FIRDataSnapshot) in
                completionHandlerForListenForAddedData(snapshot: snapshot)
            }
        } else if queryLimit != nil {
            refHandle = ref.child(pathString).queryLimitedToFirst(queryLimit!).observeEventType(.Value) { (snapshot: FIRDataSnapshot) in
                completionHandlerForListenForAddedData(snapshot: snapshot)
            }
        } else {
            refHandle = ref.child(pathString).observeEventType(.ChildAdded) { (snapshot: FIRDataSnapshot) in
                completionHandlerForListenForAddedData(snapshot: snapshot)
            }
        }
    }
    
    // MARK: - Listen for Removed Data
    func listenForRemovedData(pathString: String, completionHandlerForListenForRemovedData: (snapshot: FIRDataSnapshot) -> Void) {
        
        refHandle = ref.child(pathString).observeEventType(.ChildRemoved) { (snapshot: FIRDataSnapshot) in
            completionHandlerForListenForRemovedData(snapshot: snapshot)
        }
    }
    
    // MARK: - Listen for Changed Data
    func listenForChangedData(pathString: String, completionHandlerForListenForChangedData: (snapshot: FIRDataSnapshot) -> Void) {
        
        refHandle = ref.child(pathString).observeEventType(.ChildChanged) { (snapshot: FIRDataSnapshot) in
            completionHandlerForListenForChangedData(snapshot: snapshot)
        }
    }
    
    // MARK: - Stop Listening for New Data
    func stopListeningForData(pathString: String) {
        ref.child(pathString).removeAllObservers()
    }
    
}
