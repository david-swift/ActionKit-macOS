//
//  Parameter.swift
//  ActionKit
//
//  Created by david-swift on 03.02.23.
//

import Foundation

/// A parameter of a function.
public struct Parameter: Identifiable {

    /// The identifier.
    public let id: UUID
    /// The parameter's name that the user can see.
    public var name: String
    /// The parameter's type.
    public var type: ActionType.Type

    /// A parameter's initializer.
    /// - Parameters:
    ///   - name: The parameter's name.
    ///   - type: The parameter's type.
    ///   - id: The parameter's identifier.
    public init(_ name: String, type: ActionType.Type, id: UUID = .init()) {
        self.name = name
        self.type = type
        self.id = id
    }

}
