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


import Foundation;
import MedKitCore;


/**
 Patient directory protocol.
 */
public protocol PatientDirectory: class {
    
    // MARK: - Properties
    
    var reachable : Bool { get }
    
    /**
     Initialize patient directory.
     
     - Parameters:
        - completion: Completion handler.
     */
    func initialize(completionHandler completion: @escaping (Error?) -> Void);
    
    // MARK: - Observer Interface
    
    /**
     Add observer.
     
     Adds an observer to the directory using a weak reference.
     
     - Parameters:
        - observer: An observer instance.
     */
    func addObserver(_ observer: PatientDirectoryObserver);
    
    /**
     Remove observer.
     
     Remove observer from the directory.
     
     - Parameters:
        - observer: An exisitng observer to be removed from the directory
     instance.
     */
    func removeObserver(_ observer: PatientDirectoryObserver);
    
    // MARK: - Directory Updates
    
    /**
     Add patient to directory.
     
     - Parameters:
        - patient: Patient
     */
    func addPatient(_ patient: Patient, completionHandler completion: @escaping (Error?) -> Void);
    
    /**
     Remove patient from directory.
     
     - Parameters:
        - patient: Patient
     */
    func removePatient(_ patient: Patient, completionHandler completion: @escaping (Error?) -> Void);
    
    // MARK: - Search
    
    /**
     Find patient with profile.
     
     - Parameters:
        - profile: The patient profile.
     */
    func findPatient(with profile: JSON) -> Patient;
    
    /**
     Find patient with identifier.
     
     - Parameters:
        - identifier: The patient identifier.
     */
    func findPatient(withIdentifier identifier: String, completionHandler completion: @escaping (Patient?, Error?) -> Void);
    
    /**
     Search patient directory.
     
     - Parameters:
        - text:       Search text.
        - completion: Completion handler.
     */
    func search(using text: String?, completionHandler completion: @escaping ([Patient]?, Error?) -> Void);
    
}


// End of File
