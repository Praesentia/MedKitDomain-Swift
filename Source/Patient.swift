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


public typealias Name  = NameV1
public typealias Image = ImageV1


/**
 Patient protocol.
 */
public protocol Patient: class {
    
    // primary
    var  birthdate           : Date?    { get }
    var  identifier          : String   { get }
    var  name                : Name     { get }
    var  photo               : Image?   { get }
    
    var  devices             : [Device]       { get }
    var  notificationEnabled : Bool           { get }
    var  profile             : PatientProfile { get }
    
    func addObserver(_ observer: PatientObserver)
    func removeObserver(_ observer: PatientObserver)
    
    func assignDevice(_ device: Device, completionHandler completion: @escaping (Error?) -> Void)
    func enableNotification(_ enable: Bool, completionHandler completion: @escaping (Error?) -> Void)
    func updateName(_ name: Name, completionHandler completion: @escaping (Error?) -> Void)
    func updatePhoto(_ photo: Image, completionHandler completion: @escaping (Error?) -> Void)

}

public extension Patient {
    
    public static func find(from profile: PatientProfile) -> Patient
    {
        return PatientCache.main.findPatient(with: profile.info)
    }
    
}


// End of File
