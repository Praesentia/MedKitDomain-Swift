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
 Patient
 
 - Primary Patient Information
 - Birthdate:  The patient's birthday.
 - Identifier: Uniquely identifies the patient.
 - Name:       The patient's name.
 - Photo:      An optional attribute, this image is intended as an
 alternative means of confirming a patient's identity.
 */
public class PatientBase: Patient, PatientBackend {
    
    // primary
    public var  birthdate           : Date?    { return _birthdate; };
    public var  identifier          : String   { return _identifier; }
    public var  name                : Name     { return _name; };
    public var  photo               : Image?   { return _photo; };
    
    //
    public var  backend             : PatientBackendDelegate!;
    public var  devices             : [Device] { return _devices; };
    public var  notificationEnabled : Bool     { return _notificationEnabled; }
    public var  profile             : JSON     { return getProfile(); }
    
    // MARK: - Shadowed
    public var _birthdate           : Date?;
    public var _identifier          = String();
    public var _name                = Name();
    public var _notificationEnabled : Bool = false;
    public var _photo               : Image?;
    public var _devices             = [Device]();
    
    // privte
    private let observers           = ObserverManager<PatientObserver>();
    
    /**
     Patient constructor.
     - Parameters:
     - backend:
     */
    init(backend: PatientBackendDelegate)
    {
        self.backend = backend;
    }
    
    /**
     Initialize instance from object.
     - Parameters:
     - backend:
     - object:
     */
    init(backend: PatientBackendDelegate, from profile: JSON)
    {
        self.backend = backend;
        
        _birthdate  = Date.rfc3339(profile["birthdate"].string!);
        _identifier = profile[KeyIdentifier].string!;
        _name       = Name(from: profile["name"]);
        _photo      = Image(from: profile[KeyPhoto]);
    }
    
    deinit
    {
        PatientCache.main.removePatient(with: identifier);
    }
    
    public func addObserver(_ observer: PatientObserver)
    {
        observers.add(observer);
    }
    
    public func removeObserver(_ observer: PatientObserver)
    {
        observers.remove(observer);
    }
    
    /**
     Assign device to patient.
     - Parameters:
     - device:
     - completionHandler:
     */
    public func assignDevice(_ device: Device, completionHandler completion: @escaping (Error?) -> Void)
    {
        let sync = Sync();
        
        sync.incr();
        if !devices.contains(where: { $0 === device }) {
            backend.patientAssignDevice(self, device: device) { error in
                if error == nil {
                    self.observers.withEach { $0.patient(self, didAdd: device); }
                }
                sync.decr(error);
            }
        }
        else {
            sync.decr(MedKitError.Duplicate);
        }
        
        sync.close(completionHandler: completion);
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
                self._notificationEnabled = enable;
            }
            
            completion(error);
        }
    }
    
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
                self._name = name;
                self.observers.withEach { $0.patientDidUpdateName(self); }
            }
            
            completion(error);
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
                self._photo = Image(data: photo.data!);
                self.observers.withEach { $0.patientDidUpdatePhoto(self); }
            }
            
            completion(error);
        }
    }
    
    private func getProfile() -> JSON
    {
        let profile = JSON();
        
        profile["birthdate"]  = birthdate?.rfc3339;
        profile[KeyIdentifier] = identifier;
        profile["name"]        = name.profile;
        profile[KeyPhoto]      = photo?.profile;
        profile["devices"]    = devices.map() { $0.profile }
        
        return profile;
    }
    
    // MARK: - PatientBackend
    
    public func addDevice(_ device: Device)
    {
        _devices.append(device);
    }
    
}


// End of File
