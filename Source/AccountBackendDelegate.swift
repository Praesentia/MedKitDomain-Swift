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


/**
 Account backend delegate protocol.
 */
public protocol AccountBackendDelegate: class {
    
    /**
     Update account description.
     
     - Parameters:
        - account:     The account to be updated.
        - description: The new description.
        - completion:  An execution block that shall be invoked when the
                       operation has completed.
            - error: Nil if successful, otherwise the error that prevented the
                     operation from completing.

     */
    func account(_ account: AccountBackend, updateDescription description: String?, completionHandler completion: @escaping (Error?) -> Void);
    
}


// End of File
