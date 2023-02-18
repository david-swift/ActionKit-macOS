//
//  Function+.swift
//  ActionKit
//
//  Created by david-swift on 15.02.23.
//

import Foundation

extension Function {

    /// Execute the function.
    /// - Parameters:
    ///   - input: The function's input node's output values.
    ///   - startedStep: A function that is called before the execution of every node.
    /// - Returns: The function's output node's input values.
    func function(input: [ActionType], startedStep: (Int) -> Void = { _ in }) throws -> [ActionType] {
        var input = input
        if input.count >= 1 {
            input.removeFirst()
        }
        if let getOutput {
            let output = getOutput(input)
            startedStep(0)
            return [ControlFlow.signal] + output
        }
        return try getCustomOutput(input: input, startedStep: startedStep)
    }

    /// Execute a custom function.
    /// Check the function first with ``check()``.
    /// - Parameters:
    ///   - input: The function's input node's output values.
    ///   - startedStep: A function that is called before every execution of a node.
    /// - Returns: The function's output node's input values.
    func getCustomOutput(input: [ActionType], startedStep: (Int) -> Void) throws -> [ActionType] {
        var output: [ActionType] = []
        var data: [ActionData] = allNodes.enumerated().flatMap { index, node in
            var data: [ActionData] = []
            node.values.forEach { key, value in
                data.append(.init(position: .input(node: index, point: key), value: value))
            }
            return data
        }
        let functions = allFunctions(input: input) { newValue in
            output = newValue
        }
        var allNodes = allNodes

        while true {
            var nothingChanged = true
            for node in allNodes {
                try checkNode(node: node, data: data) { index, inputValues in
                    nothingChanged = false
                    startedStep(index)
                    do {
                        let output = try functions[id: node.function]?.function(
                            input: inputValues.map { $0.value }
                        ) ?? []
                        for (outputIndex, value) in output.enumerated() {
                            data.append(.init(position: .output(node: index, point: outputIndex), value: value))
                        }
                        allNodes = allNodes.filter { $0.id != node.id }
                    } catch ExecutionError.emptyIteration(node: _) {
                        throw ExecutionError.emptyIteration(node: index)
                    }
                }
            }
            if output.count == self.output.count - 1 {
                return output
            } else if nothingChanged {
                throw ExecutionError.emptyIteration(node: nil)
            } else {
                output = []
            }
        }
    }

    /// Execute a certain node if it can be executed.
    /// - Parameters:
    ///   - node: The node to check.
    ///   - data: Data collected from other nodes.
    ///   - run: Run when the node can be executed with the node's index and data as parameters.
    private func checkNode(node: Node, data: [ActionData], run: (Int, [ActionData]) throws -> Void) throws {
        guard let index = allNodes.firstIndex(where: { $0.id == node.id }) else {
            return
        }
        let inputs = getWires(to: index)
        // Get the values of the wires that end at the node's index.
        var inputValues: [ActionData.ActionInputData] = inputs.compactMap { input in
            guard let data = data.first(where: { data in
                switch data.position {
                case let .output(node, point):
                    return (node, point) == input.start
                default:
                    return false
                }
            }) else {
                return nil
            }
            return ActionData.ActionInputData(input: input.end, data: data)
        }
        inputValues += data.compactMap { data in
            switch data.position {
            case let .input(node, point):
                if node == index {
                    return .init(input: (node, point), data: data)
                }
            default:
                break
            }
            return nil
        }
        inputValues.sort { $0.input.1 <= $1.input.1 }
        guard let inputs = editableAllFunctions[id: node.function]?.input else {
            return
        }
        let requiresOneInput = functions[id: node.function]?.requireOnlyOneInput == true
        let condition = requiresOneInput ? inputValues.count > 1 : inputs.indices.allSatisfy { inputIndex in
            let valueExists = inputValues.contains { $0.input == (index, inputIndex) }
            return valueExists
        }
        guard let firstValue = node.id == .inputID ? ControlFlow.signal
                : inputValues.first?.data.value as? ControlFlow else {
            return
        }
        if condition && firstValue == .signal {
            try run(index, inputValues.map { $0.data })
        }
    }

    /// Execute the function as the developer.
    /// - Parameters:
    ///   - input: The input values. You should not add the default control flow signal.
    ///   - startedStep: A function that is executed before the execution of every node.
    /// - Returns: The function's output without the default control flow signal.
    public func run(input: [ActionType], startedStep: (Int) -> Void = { _ in }) throws -> [ActionType] {
        let input = [ControlFlow.signal] + input
        return try function(input: input, startedStep: startedStep)
    }

    /// Get the wires to a specified node.
    /// - Parameter node: The node's index in ``allNodes(input:output:)``.
    /// - Returns: An array containing the wires.
    private func getWires(to node: Int) -> [Wire] {
        wires.filter { $0.end.0 == node }
    }

}
