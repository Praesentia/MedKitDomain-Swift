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


/**
 AccountManager protocol.
 */
public protocol AccountManager {
    
    /**
     Accounts
     
     A list of the accounts.
     */
    var  accounts : [Account] { get }
    
    /**
     Primary account.
     */
    var  primary  : Account?  { get }
    
    /**
     Initialize
     */
    func initialize(completionHandler completion: @escaping (Error?) -> Void)
    
    /**
     Add observer.
     */
    func addObserver(_ observer: AccountManagerObserver)

    /**
     Remove observer.
     */
    func removeObserver(_ observer: AccountManagerObserver)
    
    /**
     Add account.
     */
    func addAccount(with identity: Identity, description: String?, secret: [UInt8], completionHandler completion: @escaping (Account?, Error?) -> Void)
    
    /**
     Remove account.
     */
    func removeAccount(with identity: Identity, completionHandler completion: @escaping (Error?) -> Void)
    
    /**
     Update primary account.
     */
    func updatePrimary(_ account: Account?)
    
}


// End of File
