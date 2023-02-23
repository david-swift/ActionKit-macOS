//
//  Wire.swift
//  ActionKit
//
//  Created by david-swift on 30.01.23.
//

import Foundation

/// A connection between nodes in the ``FunctionEditor``.
public struct Wire: Identifiable, Equatable, Codable {

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

    /// Initialize a wire from data.
    /// - Parameter decoder: The decoder.
    public init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)
        id = .init()
        start = (
            try decoder.decode(Int.self, forKey: .startNode),
            try decoder.decode(Int.self, forKey: .startPoint)
        )
        end = (
            try decoder.decode(Int.self, forKey: .endNode),
            try decoder.decode(Int.self, forKey: .endPoint)
        )
    }

    /// The wire's coding keys.
    enum CodingKeys: CodingKey {
        /// The coding key for the start position's node.
        case startNode
        /// The coding key for the start position's point.
        case startPoint
        /// The coding key for the end position's node.
        case endNode
        /// The coding key for the end position's point.
        case endPoint
    }

    /// Checks whether two wires are equal.
    /// - Parameters:
    ///   - lhs: The first wire.
    ///   - rhs: The second wire.
    /// - Returns: Whether the two wires are equal.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.start == rhs.start && lhs.end == rhs.end
    }

    /// Encode a wire.
    /// - Parameter encoder: The encoder.
    public func encode(to encoder: Encoder) throws {
        var encoder = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encode(start.0, forKey: .startNode)
        try encoder.encode(start.1, forKey: .startPoint)
        try encoder.encode(end.0, forKey: .endNode)
        try encoder.encode(end.1, forKey: .endPoint)
    }

}
