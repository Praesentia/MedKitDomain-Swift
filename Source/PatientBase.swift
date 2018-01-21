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
import MedKitAssignedNumbers
import MedKitCore


/**
 Patient
 
 - Primary Patient Information
 - Birthdate:  The patient's birthday.
 - Identifier: Uniquely identifies the patient.
 - Name:       The patient's name.
 - Photo:      An optional attribute, this image is intended as an
 alternative means of confirming a patient's identity.
 */
public class PatientBase: Patient, PatientBackend {
    
    // MARK: - Properties
    public private(set) var  birthdate  : Date?
    public private(set) var  identifier = String()
    public private(set) var  name       = Name()
    public private(set) var  photo      : Image?
    
    //
    public var               backend             : PatientBackendDelegate!
    public internal(set) var devices             = [Device]() // TODO: internal
    public private(set)  var notificationEnabled = false
    public var               profile             : PatientProfile { return PatientProfile(from: self) }
    
    // privte
    private var observers = [PatientObserver]()
    
    // MARK: - Initializers/Deinitializers
    
    /**
     Patient constructor.
     - Parameters:
     - backend:
     */
    init(backend: PatientBackendDelegate)
    {
        self.backend = backend
    }

    /**
     Initialize instance from object.

     - Parameters:
         - backend:
         - patientInfo:
     */
    init(backend: PatientBackendDelegate, from patientInfo: PatientInfo)
    {
        self.backend = backend

        birthdate  = patientInfo.birthdate
        identifier = patientInfo.identifier
        name       = patientInfo.name
        photo      = patientInfo.photo
    }

    /**
     Initialize instance from object.

     - Parameters:
         - backend:
         - patientProfile:
     */
    init(backend: PatientBackendDelegate, from patientProfile: PatientProfile)
    {
        self.backend = backend
        
        birthdate  = patientProfile.info.birthdate
        identifier = patientProfile.info.identifier
        name       = patientProfile.info.name
        photo      = patientProfile.info.photo
    }
    
    deinit
    {
        PatientCache.main.removePatient(with: identifier)
    }
    
    // MARK: Observer Interface
    
    public func addObserver(_ observer: PatientObserver)
    {
        observers.append(observer)
    }
    
    public func removeObserver(_ observer: PatientObserver)
    {
        if let index = observers.index(where: { $0 === observer }) {
            observers.remove(at: index)
        }
    }
    
    // MARK: Device Management
    
    /**
     Assign device to patient.
     - Parameters:
     - device:
     - completionHandler:
     */
    public func assignDevice(_ device: Device, completionHandler completion: @escaping (Error?) -> Void)
    {
        let sync = Sync()
        
        sync.incr()
        if !devices.contains(where: { $0 === device }) {
            backend.patientAssignDevice(self, device: device) { error in
                if error == nil {
                    self.observers.forEach { $0.patient(self, didAdd: device) }
                }
                sync.decr(error)
            }
        }
        else {
            sync.decr(MedKitError.duplicate)
        }
        
        sync.close(completionHandler: completion)
    }
    
    /**
     Enable patient notification.
     
     - Parameters:
        - enable:
        - completionHandler:
     */
    public func enableNotification(_ enable: Bool, completionHandler completion: @escaping (Error?) -> Void)
    {
        backend.patientEnableNotification(self, enable: enable) { error in
            
            if error == nil {
                self.notificationEnabled = enable
            }
            
            completion(error)
        }
    }
    
    // MARK: - Mutators
    
    /**
     Update patient name.
     - Parameters:
     - name:
     - completionHandler:
     */
    public func updateName(_ name: Name, completionHandler completion: @escaping (Error?) -> Void)
    {
        backend.patientUpdateName(self, name: name) { error in
            
            if error == nil {
                self.name = name
                self.observers.forEach { $0.patientDidUpdateName(self) }
            }
            
            completion(error)
        }
    }
    
    /**
     Update patient photo.
     - Parameters:
     - photo:
     - completionHandler:
     */
    public func updatePhoto(_ photo: Image, completionHandler completion: @escaping (Error?) -> Void)
    {
        backend.patientUpdatePhoto(self, photo: photo) { error in
            
            if error == nil {
                self.photo = Image(data: photo.data!)
                self.observers.forEach { $0.patientDidUpdatePhoto(self) }
            }
            
            completion(error)
        }
    }
    
    // MARK: - PatientBackend
    
    public func addDevice(_ device: Device)
    {
        devices.append(device)
    }
    
}


// End of File
