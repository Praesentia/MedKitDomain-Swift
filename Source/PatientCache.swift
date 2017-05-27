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
 Patient Cache
 */
public class PatientCache {
    
    public static let main = PatientCache();
    
    public var backend: PatientBackendDelegate! = DefaultBackend.main;
    
    private struct Entry {
        unowned let patient: PatientBase;
        
        init(_ patient: PatientBase)
        {
            self.patient = patient;
        }
    }
    
    private var cache = [String : Entry]();
    
    func findPatient(with identifier: String) -> Patient?
    {
        return cache[identifier]?.patient;
    }
    
    func findPatient(from profile: JSON) -> Patient
    {
        let identifier = profile[KeyIdentifier].string!;
        let patient    : PatientBase;
        
        if let entry = cache[identifier] {
            patient = entry.patient;
        }
        else {
            patient = PatientBase(backend: backend, from: profile);
            cache[identifier] = Entry(patient);
            
            if let assignedDevices = profile["devices"].array {
                for profile in assignedDevices {
                    patient.devices.append(DeviceProxyNetCache.main.findDevice(from: profile));
                }
            }
        }
        
        return patient;
    }
    
    func removePatient(with identifier: String)
    {
        cache[identifier] = nil;
    }
    
}


// End of File
