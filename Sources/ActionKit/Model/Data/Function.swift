//
//  Function.swift
//  ActionKit
//
//  Created by david-swift on 29.01.23.
//

import ColibriComponents
import SwiftUI

/// A function that can be edited in the ``FunctionEditor`` or executed.
public struct Function: Identifiable, Equatable, ColibriComponents.Bindable {

    /// The function's identifier.
    public let id: String
    /// The function's name.
    public var name: String
    /// A short description of the function.
    public var description: String

    /// The input parameters.
    public private(set) var dataInput: [Parameter]
    /// The output parameters.
    public private(set) var dataOutput: [Parameter]

    /// The input parameters with the control flow.
    public var input: [Parameter] {
        get {
            if id == .input {
                return []
            } else {
                return [controlFlow] + dataInput
            }
        }
        set {
            dataInput = newValue.filter { $0.type != ControlFlow.self }
        }
    }
    /// The output parameters with the control flow.
    public var output: [Parameter] {
        get {
            if id == .output {
                return []
            } else {
                return [controlFlow] + dataOutput
            }
        }
        set {
            dataOutput = newValue.filter { $0.type != ControlFlow.self }
        }
    }
    /// The control flow parameter.
    let controlFlow: Parameter = .init(
        .init(localized: .init("Control Flow", comment: "Function (The control flow parameter name)") ),
        type: ControlFlow.self,
        id: .controlFlowID
    )

    /// The function for getting the output for functions defined by the developer.
    /// Nil in functions defined by the user.
    var getOutput: (([ActionType]) -> [ActionType])?
    /// The nodes in the function.
    private(set) var nodes: [Node]
    /// The position of the input node in the ``FunctionEditor``.
    private(set) var inputNodePosition: CGPoint
    /// The position of the output node in the ``FunctionEditor``.
    private(set) var outputNodePosition: CGPoint
    /// Values for the output node that are defined manually.
    private(set) var outputNodeValues: [Int: ActionType]
    /// The connections between the nodes.
    var wires: [Wire]

    /// Whether the function requires only one input or all the inputs to run.
    /// This input is then given as the first input.
    /// There is no way to build such a function with nodes.
    var requireOnlyOneInput: Bool

    /// The functions that the nodes can access ordered in groups.
    var groupedFunctions: [Folder<Self>]

    /// The functions that the nodes can access.
    var functions: [Self] {
        groupedFunctions.flatMap { $0.content }
    }

    /// The function nodes' witdth in the ``FunctionEditor``.
    var width: CGFloat

    /// The input node.
    private var inputNode: Node {
        .init(
            function: .input,
            id: .inputID,
            position: inputNodePosition,
            values: [:]
        )
    }

    /// The output node.
    /// - Parameter output: Function for getting the input values of the output node.
    /// - Returns: The output node.
    private var outputNode: Node {
        .init(
            function: .output,
            id: .outputID,
            position: outputNodePosition,
            values: outputNodeValues
        )
    }

    /// Get all the available nodes for the function including input and output.
    var allNodes: [Node] {
        get {
            [inputNode] + nodes + [outputNode]
        }
        set {
            for node in newValue {
                if node.function == .input {
                    inputNodePosition = node.position
                } else if node.function == .output {
                    outputNodePosition = node.position
                    outputNodeValues = node.values
                } else if let index = nodes.firstIndex(where: { $0.id == node.id }) {
                    nodes[safe: index] = node
                } else {
                    nodes.append(node)
                    wires = wires.map { wire in
                        if wire.end.0 + 1 == newValue.count - 1 {
                            var wire = wire
                            wire.end.0 += 1
                            return wire
                        }
                        return wire
                    }
                }
            }
            for (index, node) in allNodes.enumerated() where !newValue.contains(where: { $0.id == node.id }) {
                nodes.remove(at: index - 1)
                wires = wires.compactMap { wire in
                    var wire = wire
                    if wire.start.0 == index || wire.end.0 == index {
                        return nil
                    } else {
                        if wire.start.0 > index {
                            wire.start.0 -= 1
                        }
                        if wire.end.0 > index {
                            wire.end.0 -= 1
                        }
                    }
                    return wire
                }
            }
        }
    }

    /// ``allFunctions(input:output:)`` without the input and output specified with a setter.
    /// It is ideal for editing and viewing the functions, but not for executing the whole function.
    var editableAllFunctions: [Self] {
        get {
            allFunctions(input: []) { _ in }
        }
        set {
            for (index, group) in groupedFunctions.enumerated() {
                for (functionIndex, function) in group.content.enumerated() {
                    if let function = newValue.first(where: { $0.id == function.id }) {
                        groupedFunctions[safe: index]?.content[safe: functionIndex] = function
                    }
                }
            }
        }
    }

    /// The number of inputs if there are more inputs than outputs
    /// or the number of outputs otherwise.
    var maxCount: Int {
        max(input.count, output.count)
    }

    /// Get the node at a certain index.
    /// Note that the input and output nodes do not have the functions for execution assigned.
    /// Therefore, this subscript cannot be used for execution.
    /// - Parameters:
    ///   - node: The node's index.
    public subscript (node node: Int) -> Node? {
        get {
            allNodes[safe: node]
        }
        set {
            allNodes[safe: node] = newValue
        }
    }

    /// Get the parameter at a certain index.
    /// - Parameters:
    ///   - parameter: The index of the paramter's node and the index of the parameter in this node.
    ///   - input: Whether it is an input or output parameter.
    public subscript (parameter parameter: (Int, Int), input input: Bool) -> Parameter? {
        get {
            let function = functions[id: allNodes[safe: parameter.0]?.function]
            if input {
                return function?.input[safe: parameter.1]
            } else {
                return function?.output[safe: parameter.1]
            }
        }
        set {
            if input {
                editableAllFunctions[id: allNodes[safe: parameter.0]?.function]?.input[safe: parameter.1] = newValue
            } else {
                editableAllFunctions[id: allNodes[safe: parameter.0]?.function]?.output[safe: parameter.1] = newValue
            }
        }
    }

    /// The function's initializer.
    /// - Parameters:
    ///   - id: The function's id.
    ///   - name: The function's name.
    ///   - description: A short description of the function.
    ///   - input: The input parameters.
    ///   - output: The output parameters.
    ///   - getOutput: The function for getting the output in a function defined by the developer.
    ///   - nodes: The nodes in a function defined by the user.
    ///   - wires: The wires in a function defined by the user.
    ///   - functions: The functions available for the user for defining the parent function.
    public init(
        id: String,
        name: String,
        description: String,
        input: [Parameter] = [],
        output: [Parameter] = [],
        getOutput: ( ([ActionType]) -> [ActionType])? = nil,
        nodes: [Node] = [],
        wires: [Wire] = [],
        functions: [Folder<Self>] = .init()
    ) {
        self.init(
            functionID: id,
            name: name,
            description: description,
            input: input,
            output: output,
            getOutput: getOutput,
            nodes: nodes,
            wires: wires,
            functions: functions
        )
    }

    /// The function's initializer.
    /// - Parameters:
    ///   - functionID: The function's id.
    ///   - name: The function's name.
    ///   - description: A short description of the function.
    ///   - input: The input parameters.
    ///   - output: The output parameters.
    ///   - getOutput: The function for getting the output in a function defined by the developer.
    ///   - nodes: The nodes in a function defined by the user.
    ///   - wires: The wires in a function defined by the user.
    ///   - functions: The functions available for the user for defining the parent function.
    ///   - outputNodeValues: The manually defined values of the output node.
    ///   - width: The node's width.
    init(
        functionID: String,
        name: String,
        description: String,
        input: [Parameter] = [],
        output: [Parameter] = [],
        getOutput: ( ([ActionType]) -> [ActionType])? = nil,
        nodes: [Node] = [],
        wires: [Wire] = [],
        functions: [Folder<Self>] = .init(),
        outputNodeValues: [Int: ActionType] = [0: ControlFlow.signal],
        width: CGFloat = 150,
        inputNodePosition: CGPoint = .init(
            x: .halfEditorSideLength - .standardNodePositionXOffset,
            y: .halfEditorSideLength + .standardNodePositionYOffset
        ),
        outputNodePosition: CGPoint = .init(
            x: .halfEditorSideLength + .standardNodePositionXOffset,
            y: .halfEditorSideLength - .standardNodePositionYOffset
        )
    ) {
        self.id = functionID
        self.name = name
        self.description = description
        self.dataInput = input
        self.dataOutput = output
        self.getOutput = getOutput
        self.nodes = nodes
        self.wires = wires
        self.groupedFunctions = functions
        requireOnlyOneInput = false
        self.outputNodeValues = outputNodeValues
        self.width = width
        self.inputNodePosition = inputNodePosition
        self.outputNodePosition = outputNodePosition
    }

    /// Errors that can occur while executing a function.
    public enum ExecutionError: Error {

        /// There was an iteration without any change.
        case emptyIteration(node: Int?)

    }

    /// Check whether two functions are equal.
    /// - Parameters:
    ///   - lhs: The first function.
    ///   - rhs: The second function.
    /// - Returns: Whether the two functions are equal.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.wires == rhs.wires && lhs.allNodes == rhs.allNodes
    }

    /// The functions with the input and output function.
    /// - Parameters:
    ///   - input: The output of the input node.
    ///   - output: Get the input of the output node.
    /// - Returns: The functions.
    func allFunctions(input: [ActionType], output: @escaping ([ActionType]) -> Void) -> [Self] {
        [inputFunction(input: input)] + functions + [outputFunction(output: output)]
    }

    /// The function for the input node.
    /// - Parameter input: The input node's output values.
    /// - Returns: The function.
    private func inputFunction(input: [ActionType]) -> Self {
        .init(
            id: .input,
            name: .init(localized: .init("Input", comment: "Function (Node \"Input\")") ),
            description: .init(
                localized: .init(
                    "Get the input values of the function.",
                    comment: "Function (Description of node \"Input\")"
                )
            ),
            output: self.dataInput
        ) { _ in input }
    }

    /// The function for the output node.
    /// - Parameter output: The function for handling the output node's input values.
    /// - Returns: The function.
    private func outputFunction(output: @escaping ([ActionType]) -> Void) -> Self {
        .init(
            id: .output,
            name: .init(localized: .init("Output", comment: "Function (Node \"Output\")") ),
            description: .init(
                localized: .init(
                    "Set the output values of the function.",
                    comment: "Function (Description of node \"Output\")"
                )
            ),
            input: self.dataOutput
        ) { input in
            output(input)
            return []
        }
    }

}
