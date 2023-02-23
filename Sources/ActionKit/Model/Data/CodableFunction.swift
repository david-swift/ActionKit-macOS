//
//  CodableFunction.swift
//  ActionKit
//
//  Created by david-swift on 23.02.23.
//

import Foundation

/// A wrapper around a function that make the function codable.
/// You can encode and decode the data that the user can edit.
/// The other data is stored in the static variables of the type conforming to ``CodableFunctionInformation``.
public struct CodableFunction<Information>: Codable where Information: CodableFunctionInformation {

    /// The function.
    public var function: Function

    /// Initialize a new codable function.
    /// - Parameters:
    ///   - id: The function's identifier.
    ///   - name: The function's name.
    ///   - description: A description.
    ///   - nodes: The nodes in the function. The user can always add new nodes.
    ///   - wires: The wires in the function. The user can always add new wires.
    public init(
        id: String,
        name: String,
        description: String,
        nodes: [Node] = [],
        wires: [Wire] = []
    ) {
        function = .init(
            id: id,
            name: name,
            description: description,
            input: Information.input,
            output: Information.output,
            nodes: nodes,
            wires: wires,
            functions: Information.functions
        )
    }

    /// Initialize a codable function with a decoder.
    /// - Parameter decoder: The decoder.
    public init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)
        let id = try decoder.decode(String.self, forKey: .id)
        let name = try decoder.decode(String.self, forKey: .name)
        let description = try decoder.decode(String.self, forKey: .description)
        let nodeIDs = try decoder.decode([UUID].self, forKey: .nodeIDs)
        let nodePositions = try decoder.decode([CGPoint].self, forKey: .nodePositions)
        let nodeFunctions = try decoder.decode([String].self, forKey: .nodeFunctions)
        let nodeValueKeys = try decoder.decode([[Int]].self, forKey: .nodeValueKeys)
        let nodeValueValues = try decoder.decode([[Information]].self, forKey: .nodeValueValues)
        let nodes = nodeIDs.indices.map { index in
            let nodeValueKeys = nodeValueKeys[safe: index] ?? []
            let nodeValueValues = nodeValueValues[safe: index] ?? []
            return Node(
                function: nodeFunctions[safe: index] ?? .init(),
                id: nodeIDs[safe: index] ?? .init(),
                position: nodePositions[safe: index] ?? .zero,
                values: nodeValueKeys.indices.reduce(into: [Int: ActionType]()) { partialResult, index in
                    partialResult[nodeValueKeys[safe: index] ?? 0] = nodeValueValues[safe: index]?.type
                }
            )
        }
        let outputNodeValueKeys = try decoder.decode([Int].self, forKey: .outputNodeValueKeys)
        let outputNodeValueValues = try decoder.decode([Information].self, forKey: .outputNodeValueValues)
        let outputNodeValues = outputNodeValueKeys.reduce(into: [Int: ActionType]()) { partialResult, newValue in
            partialResult[newValue] = outputNodeValueValues[safe: newValue]?.type
        }
        let wires = try decoder.decode([Wire].self, forKey: .wires)
        let width = try decoder.decode(CGFloat.self, forKey: .width)
        let inputNodePosition = try decoder.decode(CGPoint.self, forKey: .inputNodePosition)
        let outputNodePosition = try decoder.decode(CGPoint.self, forKey: .outputNodePosition)
        function = .init(
            functionID: id,
            name: name,
            description: description,
            input: Information.input,
            output: Information.output,
            nodes: nodes,
            wires: wires,
            functions: Information.functions,
            outputNodeValues: outputNodeValues,
            width: width,
            inputNodePosition: inputNodePosition,
            outputNodePosition: outputNodePosition
        )
    }

    /// The coding keys for a ``CodableFunction``.
    enum CodingKeys: CodingKey {
        /// The coding key for the function's identifier.
        case id
        /// The coding key for the function's name.
        case name
        /// The coding key for the function's description.
        case description
        /// The coding key for the identifiers of all of the nodes.
        case nodeIDs
        /// The coding key for the position of all of the nodes.
        case nodePositions
        /// The coding key for the functions of all of the nodes.
        case nodeFunctions
        /// The coding key for the keys of all of the nodes' manually defined values.
        case nodeValueKeys
        /// The coding key for the manually defined function values.
        case nodeValueValues
        /// The coding key for the key of the output node's manually defined values.
        case outputNodeValueKeys
        /// The coding key for the manually defined values for the output function.
        case outputNodeValueValues
        /// The coding key for the function's wires.
        case wires
        /// The coding key for the function's width.
        case width
        /// The coding key for the position of the input node.
        case inputNodePosition
        /// The coding key for the position of the output node.
        case outputNodePosition
    }

    /// Encode a codable function.
    /// - Parameter encoder: The encoder.
    public func encode(to encoder: Encoder) throws {
        var encoder = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encode(function.id, forKey: .id)
        try encoder.encode(function.name, forKey: .name)
        try encoder.encode(function.description, forKey: .description)
        try encoder.encode(function.nodes.map { $0.id }, forKey: .nodeIDs)
        try encoder.encode(function.nodes.map { $0.position }, forKey: .nodePositions)
        try encoder.encode(function.nodes.map { $0.function }, forKey: .nodeFunctions)
        let nodeValues = function.nodes.map { $0.values.map { ($0.key, $0.value) } }
        try encoder.encode(nodeValues.map { $0.map { $0.0 } }, forKey: .nodeValueKeys)
        try encoder.encode(nodeValues.map { $0.map { Information(type: $0.1) } }, forKey: .nodeValueValues)
        let outputNodeValues = function.outputNodeValues.map { ($0.key, $0.value) }
        try encoder.encode(outputNodeValues.map { $0.0 }, forKey: .outputNodeValueKeys)
        try encoder.encode(outputNodeValues.map { Information(type: $0.1) }, forKey: .outputNodeValueValues)
        try encoder.encode(function.wires, forKey: .wires)
        try encoder.encode(function.width, forKey: .width)
        try encoder.encode(function.inputNodePosition, forKey: .inputNodePosition)
        try encoder.encode(function.outputNodePosition, forKey: .outputNodePosition)
    }

}
