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


/**
 Account observer protocol.
 
 Used to notify observers of changes to an account.
 */
public protocol AccountObserver: class {
    
    /**
     Account did update credentials.
     
     Notifies the observer that the account credentials have changed.
     
     - Parameters:
        - account: The account for which the credentials where updated.
     */
    func accountDidUpdateCredentials(_ account: Account)
    
    /**
     Account did update description.
     
     Notifies the observer that the account description has changed.
     
     - Parameters:
        - account: The account for which the description was updated.
     */
    func accountDidUpdateDescription(_ account: Account)
    
}


// End of File
