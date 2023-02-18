//
//  Wire.swift
//  ActionKit
//
//  Created by david-swift on 30.01.23.
//

import Foundation

/// A connection between nodes in the ``FunctionEditor``.
public struct Wire: Identifiable, Equatable {

    /// The identifier.
    public let id: UUID
    /// The start parameter.
    var start: (Int, Int)
    /// The end parameter.
    var end: (Int, Int)

    /// Initialize a new wire.
    /// - Parameters:
    ///   - start: The start parameter.
    ///   - end: The end parameter.
    public init(from start: (Int, Int), to end: (Int, Int)) {
        id = .init()
        self.start = start
        self.end = end
    }

    /// Checks whether two wires are equal.
    /// - Parameters:
    ///   - lhs: The first wire.
    ///   - rhs: The second wire.
    /// - Returns: Whether the two wires are equal.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.start == rhs.start && lhs.end == rhs.end
    }

}
