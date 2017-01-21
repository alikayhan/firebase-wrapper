//
//  FirebaseAuthConvenience.swift
//  Marketolist
//
//  Created by Ali Kayhan on 29/08/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

// MARK: - FirebaseClient (Convenient Resource Methods)

extension FirebaseClient {

    // MARK: - Check User Login Status
    func checkUserLoginStatus(completionHandlerForUserHasAlreadyLoggedIn: (user: FIRUser?) -> Void) {
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                completionHandlerForUserHasAlreadyLoggedIn(user: user)
            } else {
                completionHandlerForUserHasAlreadyLoggedIn(user: nil)
            }
        }
    }
    
    // MARK: - Login with E-mail and Password
    func loginWithEmail(email: String, password: String, completionHandlerForLoginWithEmail: (user: FIRUser?, error: NSError?) -> Void) {
        FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) in
            if let user = user {
                completionHandlerForLoginWithEmail(user: user, error: nil)
            } else {
                completionHandlerForLoginWithEmail(user: nil, error: error)
            }
        }
    }
    
    // MARK: - Login with Facebook
//    func loginWithFacebook(readPermissions: [String], viewController: UIViewController, completionHandlerForLoginWithFacebook: (user: FIRUser?, error: NSError?) -> Void) {
//        
//        FacebookClient.sharedInstance().loginWithReadPermissions(readPermissions, viewController: viewController) {
//            (tokenString, error) in
//            if let tokenString = tokenString {
//                FIRAuth.auth()?.signInWithCredential(FIRFacebookAuthProvider.credentialWithAccessToken(tokenString)) { (user, error) in
//                    if let error = error {
//                        completionHandlerForLoginWithFacebook(user: nil, error: error)
//                    } else {
//                        completionHandlerForLoginWithFacebook(user: user, error: nil)
//                    }
//                }
//            } else if let error = error {
//                completionHandlerForLoginWithFacebook(user: nil, error: error)
//            } else {
//                completionHandlerForLoginWithFacebook(user: nil, error: nil)
//            }
//        }
//    }
    
    // MARK: - Login with Twitter
//    func loginWithTwitter(viewController: UIViewController, completionHandlerForLoginWithTwitter: (user: FIRUser?, error: NSError?) -> Void) {
//        TwitterClient.sharedInstance().loginWithViewController(viewController) { (authToken, authTokenSecret, error) in
//            
//            if let authToken = authToken, let authTokenSecret = authTokenSecret {
//                
//                let credential = FIRTwitterAuthProvider.credentialWithToken(authToken, secret: authTokenSecret)
//                FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
//                    
//                    if let error = error {
//                        completionHandlerForLoginWithTwitter(user: nil, error: error)
//                    } else {
//                        completionHandlerForLoginWithTwitter(user: user, error: nil)
//                    }
//                }
//                
//            } else {
//                completionHandlerForLoginWithTwitter(user: nil, error: error)
//            }
//        }
//    }
    
    // MARK: - Sign Up
    func signUp(email: String, password: String, completionHandlerForSignUp: (user: FIRUser?, error: NSError?) -> Void) {
        FIRAuth.auth()?.createUserWithEmail(email, password: password) { (user, error) in
            if let user = user {
                completionHandlerForSignUp(user: user, error: nil)                
            } else {
                completionHandlerForSignUp(user: nil, error: error)
            }
        }
    }
    
    // MARK: - User Profile Change Request
    func changeUserProfile(changeRequest: FIRUserProfileChangeRequest, completionHandlerForChangeUserProfile: (error: NSError?) -> Void) {
        changeRequest.commitChangesWithCompletion() { error in
            if let error = error {
                completionHandlerForChangeUserProfile(error: error)
            } else {
                completionHandlerForChangeUserProfile(error: nil)
            }
        }
    }
    
    // MARK: - Update E-mail
    func updateEmail(email: String, completionHandlerForUpdateEmail: (error: NSError?) -> Void) {
        FIRAuth.auth()?.currentUser?.updateEmail(email) { (error) in
            if let error = error {
                completionHandlerForUpdateEmail(error: error)
            } else {
                completionHandlerForUpdateEmail(error: nil)
            }
        }
    }
    
    // MARK: - Update Password
    func updatePassword(password: String, completionHandlerForUpdatePassword: (error: NSError?) -> Void) {
        FIRAuth.auth()?.currentUser?.updatePassword(password) { (error) in
            if let error = error {
                completionHandlerForUpdatePassword(error: error)
            } else {
                completionHandlerForUpdatePassword(error: nil)
            }
        }
    }
    
    // MARK: - Reset Password
    func resetPassword(email: String, completionHandlerForResetPassword: (error: NSError?) -> Void) {
        FIRAuth.auth()?.sendPasswordResetWithEmail(email) { (error) in
            if let error = error {
                completionHandlerForResetPassword(error: error)
            } else {
                completionHandlerForResetPassword(error: nil)
            }
        }
    }
    
    // MARK: - Logout
    func logout(completionHandlerForLogout: (error: NSError?) -> Void) {
        do {
            try FIRAuth.auth()?.signOut()
            completionHandlerForLogout(error: nil)
        } catch {
            completionHandlerForLogout(error: error as NSError)
        }
    }
    
    // MARK: - Provide Error Code
    func provideErrorCode(error: NSError, completionHandlerForProvideErrorCode: (errorCode: FIRAuthErrorCode) -> Void) {
        if let errorCode = FIRAuthErrorCode(rawValue: error.code) {
            completionHandlerForProvideErrorCode(errorCode: errorCode)
        }
    }
    
}
