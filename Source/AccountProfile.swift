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
import SecurityKit


public struct AccountProfile: Codable {

    // PARM: - Properties
    public var description : String?
    public var identity    : Identity

    // MARK: - Private
    private enum CodingKeys: CodingKey {
        case description
        case identity
    }

    // MARK: - Initializers

    public init(identity: Identity)
    {
        self.description = ""
        self.identity    = identity
    }

    public init(for account: Account)
    {
        description = account.description
        identity    = account.identity
    }

    // MARK: - Codable

    public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        description = try container.decode(String.self, forKey: .description)
        identity    = try container.decode(Identity.self, forKey: .identity)
    }

    public func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(description, forKey: .description)
        try container.encode(identity, forKey: .identity)
    }

}


// End of File


