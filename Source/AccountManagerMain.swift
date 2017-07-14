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


import Foundation
import MedKitCore
import SecurityKit


/**
 Main account manager.
 */
public class AccountManagerMain: AccountManager, AccountManagerBackend {
    
    public static let shared = AccountManagerMain()
    
    public var primary  : Account?  { return backend.primary }
    public var accounts : [Account] { return backend.accounts }
    
    // backend
    public var backend  : AccountManagerBackendDelegate!
    
    // MARK: - Private
    private var observers = ObserverManager<AccountManagerObserver>()
    
    /**
     Initialize instance.
     */
    private init()
    {
    }
    
    /**
     Initialize
     */
    public func initialize(completionHandler completion: @escaping (Error?) -> Void)
    {
        backend.accountManagerInitialize(self) { error in
            if error == nil {
                self.observers.withEach { $0.accountManagerDidUpdate(self) }
            }
            completion(error)
        }
    }
    
    /**
     Add observer.
     */
    public func addObserver(_ observer: AccountManagerObserver)
    {
        observers.add(observer)
    }
    
    /**
     Remove observer.
     */
    public func removeObserver(_ observer: AccountManagerObserver)
    {
        observers.remove(observer)
    }
    
    /**
     Add account.
     */
    public func addAccount(with identity: Identity, description: String?, secret: [UInt8], completionHandler completion: @escaping (Account?, Error?) -> Void)
    {
        backend.accountManager(self, addAccountWith: identity, description: description, secret: secret) { account, error in
            if error == nil, let account = account {
                self.observers.withEach { $0.accountManager(self, didAdd: account) }
                self.updatePrimary(account)
            }
            completion(account, error)
        }
    }
    
    /**
     Remove account.
     */
    public func removeAccount(with identity: Identity, completionHandler completion: @escaping (Error?) -> Void)
    {
        if let account = accounts.find(where: { $0.identity == identity }) {
            backend.accountManager(self, removeAccountWith: identity) { error in
                if error == nil {
                    self.observers.withEach { $0.accountManager(self, didRemove: account) }
                    if account === self.primary {
                        self.updatePrimary(nil)
                    }
                }
                completion(error)
            }
        }
    }
    
    /**
     Update primary account.
     */
    public func updatePrimary(_ account: Account?)
    {
        backend.accountManager(self, updatePrimary: account)
        observers.withEach { $0.accountManagerDidUpdatePrimary(self) }
    }
    
}


// End of File
