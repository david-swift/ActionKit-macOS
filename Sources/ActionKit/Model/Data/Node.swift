//
//  Node.swift
//  ActionKit
//
//  Created by david-swift on 30.01.23.
//

import SwiftUI

/// The representation of a function in the ``FunctionEditor``.
public struct Node: Identifiable, Equatable {

    /// The node's identifier.
    public let id: UUID
    /// The node's position in the editor coordinate space.
    var position: CGPoint
    /// The identifier of the function of the node.
    var function: String
    /// Values for the input parameters.
    var values: [Int: ActionType]

    /// Whether the node is in its default configuration.
    private var isSignal: Bool {
        values[0] as? ControlFlow == .signal && values.count == 1
    }

    /// A node's initializer.
    /// - Parameters:
    ///   - function: The identifier of the function of the node.
    ///   - id: The node's identifier.
    ///   - position: The node's position in the editor coordinate space.
    ///   - values: The input parameters that are defined manually.
    public init(
        function: String,
        id: UUID = .init(),
        position: CGPoint = .init(x: .randomPosition, y: .randomPosition),
        values: [Int: ActionType] = [0: ControlFlow.signal]
    ) {
        self.id = id
        self.position = position
        self.function = function
        self.values = values
    }

    /// Checks whether two nodes are the same.
    /// - Parameters:
    ///   - lhs: The first node.
    ///   - rhs: The second node.
    /// - Returns: Whether the two nodes are the same.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.position == rhs.position && lhs.function == rhs.function && lhs.isSignal && rhs.isSignal
    }

}
