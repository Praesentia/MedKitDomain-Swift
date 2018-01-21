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
import MedKitAssignedNumbers


public typealias PatientProfile = PatientProfileV1
public typealias PatientInfo    = PatientProfileV1.PatientInfo

public extension PatientInfoV1 {

    public init(from patient: Patient)
    {
        birthdate  = patient.birthdate
        identifier = patient.identifier
        name       = patient.name
        photo      = patient.photo
    }

}

public extension PatientProfileV1 {

    public init(from patient: Patient)
    {
        info    = PatientInfo(from: patient)
        devices = []
    }

}


// End of File

