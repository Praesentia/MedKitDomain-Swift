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
 Image
 
 An image representation, consisting of either a symbolic name or the actual
 image data.
 */
public class Image {
    
    // MARK: - Types
    
    /**
     Image type.
     */
    public enum ImageType {
        case data
        case symbolic
    }

    // MARK: - Properties
    public var              base64 : String? { return data?.base64EncodedString() }
    public private(set) var data   : Data?
    public private(set) var name   : String?
    public var              profile: JSON    { return generateProfile() }
    public let              type   : ImageType
    
    // MARK: - Initializers
    
    /**
     Initialize instance.
 
     Initializes the instance with a symbolic name that may be used to
     reference actual image data stored elsewhere, such as in an assets
     database.
     
     - Parameters:
        - name: The symbolic name for the image.
     */
    public init(named name: String)
    {
        self.type = .symbolic
        self.name = name
    }
    
    /**
     Initialize instance.
     
     Initializes the instance from image data.
     
     - Parameters:
        - data: The image data.
     */
    public init(data: Data)
    {
        self.type  = .data
        self.data = data
    }
    
    /**
     Initialize instance.
     
     Initializes the instance from image data encoded as a base64 string.
     
     - Parameters:
        - base64: A base64 string encoding the image data.
     */
    public convenience init?(fromBase64 base64: String)
    {
        let data = NSData(base64Encoded: base64) as Data?
        
        if data != nil {
            self.init(data: data!)
        }
        else {
            return nil
        }
    }
    
    /**
     Initialize instance.
     
     Initializes the instance from an image profile, a JSON structure of the
     image.
     
     - Parameters:
        - profile: A JSON descriptor of the image.
     */
    public convenience init?(from profile: JSON)
    {
        switch profile["type"].string! {
        case "data" :
            self.init(fromBase64: profile["value"].string!)
            
        case "symbolic" :
            self.init(named: profile["value"].string!)
            
        default :
            return nil
        }
    }
    
    /**
     Generate a JSON profile for the image.
     
     - Returns: Returns a JSON profile for the image.
     */
    private func generateProfile() -> JSON
    {
        let profile = JSON()
        
        switch type {
        case .data :
            profile["type"]  = "data"
            profile["value"] = base64!
        
        case .symbolic :
            profile["type"]  = "symbolic"
            profile["value"] = name!
        }
        
        return profile
    }
    
}


// End of File
