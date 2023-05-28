//
//  ActionKitTests.swift
//  ActionKit
//
//  Created by david-swift on 19.01.23.
//

@testable import ActionKit
import XCTest

/// Tests for the ActionKit.
final class ActionKitTests: XCTestCase {

    /// A test function for adding two numbers.
    let add = Function(
        id: "add",
        name: "Add",
        description: "Add",
        input: [.init("Number 1", type: Double.self), .init("Number 2", type: Double.self)],
        output: [.init("Sum", type: Double.self)],
        getOutput: { input in
            let num1 = input.first as? Double ?? .init()
            let num2 = input[safe: 1] as? Double ?? .init()
            return [num1 + num2]
        },
        nodes: [],
        wires: []
    )

    /// A test function for printing text.
    let printText = Function(
        id: "print",
        name: "Print Text",
        description: "Print Text",
        input: [.init("Text", type: String.self)]
    ) { input in
        print(input.first as? String ?? "No text")
        return []
    }

    /// Test the execution of functions.
    func testExecution() throws {
        separator(function: "Print Text")
        _ = try printText.run(input: ["Hello, world!"])

        separator(function: "Text")
        let simpleCustomFunction = Function(
            id: "text",
            name: "Text",
            description: "Text",
            input: [.init("Text", type: String.self)],
            output: [.init("Text", type: String.self), .init("Text 2", type: String.self)],
            nodes: [.init(function: "add"), .init(function: "print", values: [1: "Cool"])],
            wires: [
                .init(from: (0, 1), to: (3, 1)),
                .init(from: (0, 1), to: (3, 2)),
                .init(from: (0, 0), to: (2, 0))
            ],
            functions: [.init("", icon: .init("")) { add; printText }]
        )
        XCTAssertEqual(try simpleCustomFunction.run(input: ["Hello"]) as? [String] ?? [], ["Hello", "Hello"])

        separator(function: "Add")
        let addCustomFunction = Function(
            id: "custom-add",
            name: "Add",
            description: "Add",
            input: [.init("Number 1", type: Double.self), .init("Number 2", type: Double.self)],
            output: [.init("Number", type: Double.self)],
            nodes: [.init(function: "add")],
            wires: [
                .init(from: (0, 1), to: (1, 1)),
                .init(from: (0, 2), to: (1, 2)),
                .init(from: (1, 1), to: (2, 1))
            ],
            functions: [.init("", icon: .init("")) { add }]
        )
        XCTAssertEqual(try addCustomFunction.run(input: [1.0, 2.0]) as? [Double] ?? [], [3.0])

        separator(function: "Custom in Custom")
        let customInCustomFunction = Function(
            id: "custom-in-custom",
            name: "Custom in Custom",
            description: "Custom in Custom",
            input: [.init("Number 1", type: Double.self), .init("Number 2", type: Double.self)],
            output: [.init("Number", type: Double.self)],
            nodes: [.init(function: "custom-add")],
            wires: [
                .init(from: (0, 1), to: (1, 1)),
                .init(from: (0, 2), to: (1, 2)),
                .init(from: (1, 1), to: (2, 1))
            ],
            functions: [.init("", icon: .init("")) { addCustomFunction }]
        )
        XCTAssertEqual(try customInCustomFunction.run(input: [1.0, 2.0]) as? [Double] ?? [], [3.0])
    }

    /// Print a separator.
    func separator(function: String) {
        print("-------------------------")
        print("Function \"\(function)\"")
    }

}
