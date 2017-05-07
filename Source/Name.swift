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
 Patient name.
 */
public struct Name {
    
    /**
     Format enumeration.
     */
    public enum Format {
        case FirstLast;
        case LastFirst;
    }
    
    // MARK: - Properties
    public static var defaultFormat : Format = .FirstLast;
    
    public var first     : String?;
    public var last      : String?;
    
    public var formatted : String { return format(); }
    public var profile   : JSON   { return getProfile(); }
    
    // MARK: - Initializers
    
    /**
     Initialize instance.
     */
    public init()
    {
    }
    
    /**
     Initialize instance from profile.
     */
    public init(from profile: JSON)
    {
        first = profile[KeyFirst].string;
        last  = profile[KeyLast].string;
    }
    
    // MARK: - Formatting

    public func format(format: Format = Name.defaultFormat) -> String
    {
        switch format {
        case .FirstLast :
            return "\(first ?? "-") \(last ?? "-")";
            
        case .LastFirst :
            return "\(last ?? "-"), \(first ?? "-")";
        }
    }
    
    private func getProfile() -> JSON
    {
        let profile = JSON();

        profile[KeyFirst] = first;
        profile[KeyLast]  = last;
        
        return profile;
    }
}


// End of File
