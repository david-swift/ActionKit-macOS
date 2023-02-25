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
public struct CodableFunction<Information>: Identifiable, Codable, Equatable
where Information: CodableFunctionInformation {

    /// The identifier.
    public var id: String { function.id }
    /// The function.
    public var function: Function

    /// Initialize a new codable function.
    /// - Parameters:
    ///   - id: The function's identifier.
    ///   - name: The function's name.
    ///   - description: A description.
    ///   - input: The function's input parameters.
    ///   - output: The function's output parameters.
    ///   - nodes: The nodes in the function. The user can always add new nodes.
    ///   - wires: The wires in the function. The user can always add new wires.
    public init(
        id: String,
        name: String,
        description: String,
        input: [Parameter],
        output: [Parameter],
        nodes: [Node] = [],
        wires: [Wire] = []
    ) {
        function = .init(
            id: id,
            name: name,
            description: description,
            input: input,
            output: output,
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
        let inputIDs = try decoder.decode([UUID].self, forKey: .inputIDs)
        let inputParameters = try decoder.decode([String].self, forKey: .inputParameters)
        let inputTypes = try decoder.decode([String].self, forKey: .inputTypes)
        let input = Self.getParameters(ids: inputIDs, names: inputParameters, types: inputTypes)
        let outputIDs = try decoder.decode([UUID].self, forKey: .outputIDs)
        let outputParameters = try decoder.decode([String].self, forKey: .outputParameters)
        let outputTypes = try decoder.decode([String].self, forKey: .outputTypes)
        let output = Self.getParameters(ids: outputIDs, names: outputParameters, types: outputTypes)
        let nodeIDs = try decoder.decode([UUID].self, forKey: .nodeIDs)
        let nodePositions = try decoder.decode([CGPoint].self, forKey: .nodePositions)
        let nodeFunctions = try decoder.decode([String].self, forKey: .nodeFunctions)
        let nodeValueKeys = try decoder.decode([[Int]].self, forKey: .nodeValueKeys)
        let nodeValueValues = try decoder.decode([[Information]].self, forKey: .nodeValueValues)
        let nodes = Self.getNodes(
            ids: nodeIDs,
            valueKeys: nodeValueKeys,
            valueInformation: nodeValueValues,
            functions: nodeFunctions,
            positions: nodePositions
        )
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
            input: input,
            output: output,
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
        /// The coding key for the function's input parameters' identifiers.
        case inputIDs
        /// The coding key for the function's input parameters' names.
        case inputParameters
        /// The coding key for the function's input parameters' types.
        case inputTypes
        /// The coding key for the function's output parameters' identifiers.
        case outputIDs
        /// The coding key for the function's output parameters' names.
        case outputParameters
        /// The coding key for the function's output parameters' types.
        case outputTypes
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

    /// Get the parameters from decoded data.
    /// - Parameters:
    ///   - ids: The identifiers.
    ///   - names: The parameter names.
    ///   - types: The parameter types.
    /// - Returns: The parameters.
    private static func getParameters(ids: [UUID], names: [String], types: [String]) -> [Parameter] {
        ids.indices.map { index in
            Parameter(
                names[safe: index] ?? .init(),
                type: Information.types.first { $0.name == types[safe: index] } ?? ControlFlow.self,
                id: ids[safe: index] ?? .init()
            )
        }
    }

    /// Get the nodes from decoded data.
    /// - Parameters:
    ///   - ids: The identifiers.
    ///   - valueKeys: The manually defined values' positions.
    ///   - valueInformation: The manually defined value's value.
    ///   - functions: The nodes' functions' identifiers.
    ///   - positions: The nodes' positions.
    /// - Returns: The nodes.
    private static func getNodes(
        ids: [UUID],
        valueKeys: [[Int]],
        valueInformation: [[Information]],
        functions: [String],
        positions: [CGPoint]
    ) -> [Node] {
        ids.indices.map { index in
            let nodeValueKeys = valueKeys[safe: index] ?? []
            let nodeValueValues = valueInformation[safe: index] ?? []
            return Node(
                function: functions[safe: index] ?? .init(),
                id: ids[safe: index] ?? .init(),
                position: positions[safe: index] ?? .zero,
                values: nodeValueKeys.indices.reduce(into: [Int: ActionType]()) { partialResult, index in
                    partialResult[nodeValueKeys[safe: index] ?? 0] = nodeValueValues[safe: index]?.type
                }
            )
        }
    }

    /// Encode a codable function.
    /// - Parameter encoder: The encoder.
    public func encode(to encoder: Encoder) throws {
        var encoder = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encode(function.id, forKey: .id)
        try encoder.encode(function.name, forKey: .name)
        try encoder.encode(function.description, forKey: .description)
        try encoder.encode(function.dataInput.map { $0.id }, forKey: .inputIDs)
        try encoder.encode(function.dataInput.map { $0.name }, forKey: .inputParameters)
        try encoder.encode(function.dataInput.map { $0.type.name }, forKey: .inputTypes)
        try encoder.encode(function.dataOutput.map { $0.id }, forKey: .outputIDs)
        try encoder.encode(function.dataOutput.map { $0.name }, forKey: .outputParameters)
        try encoder.encode(function.dataOutput.map { $0.type.name }, forKey: .outputTypes)
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
