/*
 -----------------------------------------------------------------------------
 This source file is part of MedKitDomain.
 
 Copyright 2017 Jon Griffeth
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 -----------------------------------------------------------------------------
 */


import Foundation;
import MedKitCore;


/**
 Account protocol.
 */
public protocol Account: class {
    
    // MARK: - Properties
    
    /**
     Account credentials.
     
     Account credentials are used to authenticate the account identity.
     */
    var credentials: Credentials { get }
    
    /**
     Account description.
     
     A short description of the account, provided as a convenience.
     */
    var description: String? { get }
    
    /**
     Account identity.
     
     Uniquely identifies the account.
     */
    var identity: Identity { get }
    
    /**
     Principal.
     
     A Principal representation of the account.
     */
    var principal: Principal { get }
    
    // MARK: - Observers
    
    /**
     Add observer.
     
     Adds an observer to the account instance using a weak reference.
     
     - Parameters:
        - observer: An observer instance.
     */
    func addObserver(_ observer: AccountObserver);
    
    /**
     Remove observer.
     
     Remove observer from the account instance.
     
     - Parameters:
        - observer: An exisitng observer to be removed from the account
                    instance.
     */
    func removeObserver(_ observer: AccountObserver);
    
    // MARK: - Properties Updates
    
    /**
     Update description.
     
     Update the account description.
     
     - Parameters:
        - description: The new description.
        - completion:  An execution block that will be invoked when the
                       operation has completed.
            - error: Nil if successful, otherwise the error that prevented the
                     operation from completing.
     */
    func updateDescription(_ description: String?, completionHandler completion: @escaping (Error?) -> Void);
    
}


// End of File
