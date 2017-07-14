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
import SecurityKit


/**
 AccountManager backend delegate protocol.
 */
public protocol AccountManagerBackendDelegate: class {
    
    var accounts : [Account] { get }
    var primary  : Account?  { get }
    
    func accountManagerInitialize(_ manager: AccountManagerBackend, completionHandler completion: @escaping (Error?) -> Void)
    
    func accountManager(_ manager: AccountManagerBackend, addAccountWith identity: Identity, description: String?, secret: [UInt8], completionHandler completion: @escaping (Account?, Error?) -> Void)
    func accountManager(_ manager: AccountManagerBackend, removeAccountWith identity: Identity, completionHandler completion: @escaping (Error?) -> Void)
    
    func accountManager(_ manager: AccountManagerBackend, updatePrimary account: Account?)
    
}


// End of File
