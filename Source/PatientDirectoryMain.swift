/*
 -----------------------------------------------------------------------------
 This source file is part of MedKitDomain.
 
 Copyright 2016-2018 Jon Griffeth
 
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
 Main PatientDirectory implementation.
 */
public class PatientDirectoryMain: PatientDirectory, PatientDirectoryBackend {
    
    public static let shared = PatientDirectoryMain()
    
    // frontend
    public var reachable : Bool { return backend.patientDirectoryReachable(self) }
    
    // backend
    public var backend : PatientDirectoryBackendDelegate! = DefaultBackend.main
    
    // MARK: - Private
    private let observers = ObserverManager<PatientDirectoryObserver>()
    
    /**
     Initialize instance.
     */
    private init()
    {
    }
    
    /**
     Initialize patient directory.
     
     - Parameters:
     - completion: Completion handler.
     */
    public func initialize(completionHandler completion: @escaping (Error?) -> Void)
    {
        backend.patientDirectoryInitialize(self, completionHandler: completion)
    }
    
    
    // MARK: - Observer Interface
    
    /**
     Add observer.
     
     - Parameters:
     */
    public func addObserver(_ observer: PatientDirectoryObserver)
    {
        observers.add(observer)
    }
    
    public func removeObserver(_ observer: PatientDirectoryObserver)
    {
        observers.remove(observer)
    }
    
    // MARK: - Updates
    
    /**
     Add patient to directory.
     
     - Parameters:
     - patient: Patient
     */
    public func addPatient(_ patient: Patient, completionHandler completion: @escaping (Error?) -> Void)
    {
        backend.patientDirectory(self, add: patient, completionHandler: completion)
    }
    
    /**
     Remove patient from directory.
     
     - Parameters:
     - patient: Patient
     */
    public func removePatient(_ patient: Patient, completionHandler completion: @escaping (Error?) -> Void)
    {
        backend.patientDirectory(self, remove: patient, completionHandler: completion)
    }
    
    // MARK: - Search
    
    /**
     Find patient with profile.
     
     - Parameters:
        - profile: A patient profile.
     */
    public func findPatient(with profile: PatientProfile) -> Patient
    {
        return PatientCache.main.findPatient(from: profile)
    }
    
    /**
     Find patient with identifier.
     
     - Parameters:
        - identifier: The patient identifier.
     */
    public func findPatient(withIdentifier identifier: String, completionHandler completion: @escaping (Patient?, Error?) -> Void)
    {
        backend.patientDirectory(self, findPatientWithIdentifier: identifier, completionHandler: completion)
    }
    
    /**
     Search patient directory.
     
     - Parameters:
     - text:       Search text.
     - completion: Completion handler.
     */
    public func search(using text: String?, completionHandler completion: @escaping ([Patient]?, Error?) -> Void)
    {
        backend.patientDirectory(self, searchUsing: text, completionHandler: completion)
    }
    
}


// End of File
