/*
 -----------------------------------------------------------------------------
 This source file is part of MedKitDomain.
 
 Copyright 2017-2018 Jon Griffeth
 
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


import Foundation
import MedKitCore
import SecurityKit


/**
 Account base class.
 
 A base class for Account, providing a implementation for the frontend and
 backend protocols.
 */
public class AccountBase: Account, AccountBackend {
    
    public var description : String?
    public let identity    : Identity
    
    // backend
    public var backend : AccountBackendDelegate!
    public var profile : AccountProfile { return AccountProfile(for: self) }
    
    // MARK: - Private
    private var observers = ObserverManager<AccountObserver>()
    
    /**
     Initialize instance.
     */
    public init(identity: Identity, description: String?)
    {
        self.identity    = identity
        self.description = description
    }
    
    /**
     Initialize instance from profile.
     */
    public init(from profile: AccountProfile)
    {
        description = profile.description
        identity    = profile.identity
    }
    
    /**
     Add observer.
     
     - Parameters:
     */
    public func addObserver(_ observer: AccountObserver)
    {
        observers.add(observer)
    }
    
    public func removeObserver(_ observer: AccountObserver)
    {
        observers.remove(observer)
    }
    
    /**
     Update account description.
     
     - Parameters:
     - description: Account description.
     - completion: Completion handler.
     */
    public func updateDescription(_ description: String?, completionHandler completion: @escaping (Error?) -> Void)
    {
        backend.account(self, updateDescription: description) { error in
            if error == nil {
                self.observers.forEach { $0.accountDidUpdateDescription(self) }
            }
            completion(error)
        }
    }

}


// End of File
