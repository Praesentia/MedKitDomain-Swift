/*
 -----------------------------------------------------------------------------
 This source file is part of MedKitDomain.
 
 Copyright 2016-2017 Jon Griffeth
 
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
 Default patient backend.
 
 Provides a default implementation where most calls are unsupported.
 */
public class DefaultBackend: PatientBackendDelegate, PatientDirectoryBackendDelegate {
    
    public static let main = DefaultBackend()
    
    private init()
    {
    }
    
    // MARK: - PatientBackend
    
    open func patientAssignDevice(_ patient: PatientBackend, device: Device, completionHandler completion: @escaping (Error?) -> Void)
    {
        DispatchQueue.main.async { completion(MedKitError.notSupported) }
    }
    
    open func patientEnableNotification(_ patient: PatientBackend, enable: Bool, completionHandler completion: @escaping (Error?) -> Void)
    {
        DispatchQueue.main.async { completion(MedKitError.notSupported) }
    }
    
    open func patientUpdateName(_ patient: PatientBackend, name: Name, completionHandler completion: @escaping (Error?) -> Void)
    {
        DispatchQueue.main.async { completion(MedKitError.notSupported) }
    }
    
    open func patientUpdatePhoto(_ patient: PatientBackend, photo: Image, completionHandler completion: @escaping (Error?) -> Void)
    {
        DispatchQueue.main.async { completion(MedKitError.notSupported) }
    }
    
    // MARK: - PatientDirectoryBackend
    
    open func patientDirectoryInitialize(_ directory: PatientDirectoryBackend, completionHandler completion: @escaping (Error?) -> Void)
    {
        DispatchQueue.main.async { completion(nil) }
    }
    
    open func patientDirectoryReachable(_ directory: PatientDirectoryBackend) -> Bool
    {
        return false
    }
    
    open func patientDirectory(_ directory: PatientDirectoryBackend, add patient: Patient, completionHandler completion: @escaping (Error?) -> Void)
    {
        DispatchQueue.main.async { completion(MedKitError.notSupported) }
    }
    
    open func patientDirectory(_ directory: PatientDirectoryBackend, remove patient: Patient, completionHandler completion: @escaping (Error?) -> Void)
    {
        DispatchQueue.main.async { completion(MedKitError.notSupported) }
    }
    
    open func patientDirectory(_ directory: PatientDirectoryBackend, findPatientWithIdentifier identifier: String, completionHandler completion: @escaping (Patient?, Error?) -> Void)
    {
        DispatchQueue.main.async { completion(nil, MedKitError.notSupported) }
    }
    
    open func patientDirectory(_ directory: PatientDirectoryBackend, searchUsing text: String?, completionHandler completion: @escaping ([Patient]?, Error?) -> Void)
    {
        DispatchQueue.main.async { completion(nil, MedKitError.notSupported) }
    }
    
}


// End of File
