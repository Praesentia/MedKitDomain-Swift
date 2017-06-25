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
 AccountManager observer
 */
public protocol AccountManagerObserver: class {
    
    /**
     Account manager did add account.
     
     Notifies an observer a new account has been added to the manager.
     */
    func accountManager(_ manager: AccountManager, didAdd account: Account)
    
    /**
     Account manager did remove account.
     
     Notifies an observer an existing account has been removed from the
     manager.
     */
    func accountManager(_ manager: AccountManager, didRemove account: Account)
    
    /**
     Account manager did update.
     
     Notifies an observer that the manager has been reset, typically called
     after being initialized.
     */
    func accountManagerDidUpdate(_ manager: AccountManager)
    
    /**
     Account manager did primary.
     
     Notifies an observer that the primary account has been updated.
     */
    func accountManagerDidUpdatePrimary(_ manager: AccountManager)
    
}


// End of File
