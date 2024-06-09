//
//  Array+.swift
//  ActionKit
//
//  Created by david-swift on 17.02.23.
//

import Foundation

extension Array where Element == Folder<Function> {

    /// A set of functions for ``ControlFlow`` (Control Flow).
    public static let controlFlowFunctions: Self =
        [
            .init(
                .init(
                    localized: .init(
                        "Convert Control Flow",
                        comment: "Array (The localized name of the conversion set in the control flow functions)"
                    )
                ),
                icon: .init(systemName: "arrow.right"),
                content: controlFlowConversionFunctions
            )
        ]

    /// Convert the control flow into other types.
    public static let controlFlowConversionFunctions: [Function] = [
        Function(
            id: .controlFlowToBoolean,
            name: .init(localized: .init(
                "Control Flow to Boolean",
                comment: "Array (Function for converting the control flow into a boolean)"
            )),
            description: .init(localized: .init(
                "Convert the control flow into a boolean.",
                comment: "Array (Description of \"Control Flow to Boolean\")"
            )),
            input: [.init(.controlFlow, type: ControlFlow.self)],
            output: [.init(.boolean, type: Bool.self)]
        ) { input in
            [(input.first as? ControlFlow ?? .noSignal) == .signal]
        }
    ]

    /// The group of the merge flow functions.
    public static let mergeFlowGroup: Self =
        [
            .init(
                .init(
                    localized: .init(
                        "Merge Flow",
                        comment: "Array (The localized name of the functions for merging the flow)"
                    )
                ),
                icon: .init(systemName: "arrow.triangle.merge"),
                content: mergeFlowFunctions
            )
        ]

    /// The functions for merging the flow
    /// of ``String`` (Text), ``Double`` (Number), ``Bool`` (Boolean) and ``ControlFlow`` (Control Flow).
    public static var mergeFlowFunctions: [Function] {
        [
            String.mergeFlowFunction,
            Double.mergeFlowFunction,
            Bool.mergeFlowFunction,
            ControlFlow.mergeFlowFunction
        ]
    }

}

extension Array {

    /// Accesses the element at the specified position safely.
    /// - Parameters:
    ///   - index: The position of the element to access.
    ///
    ///   Access and set elements the safe way:
    ///   ```swift
    ///   var array = ["Hello", "World"]
    ///   print(array[safe: 2] ?? "Out of range")
    ///   ```
    public subscript(safe index: Int?) -> Element? {
        get {
            if let index, checkIndex(index) {
                return self[index]
            }
            return nil
        }
        set {
            if let index, let value = newValue, checkIndex(index) {
                self[index] = value
            }
        }
    }

    /// Check if a given index is valid for the array.
    /// - Parameter index: The index to test.
    /// - Returns: Return whether the index is valid or not.
    private func checkIndex(_ index: Int) -> Bool {
        index < count && index >= 0
    }

}

extension Array where Element: Identifiable {

    /// Accesses the element with a specified identifier safely.
    /// - Parameters:
    ///     - id: The identifier of the element to access.
    public subscript(id id: Element.ID?) -> Element? {
        get {
            let index = getIndex(id: id)
            return self[safe: index]
        }
        set {
            let index = getIndex(id: id)
            self[safe: index] = newValue
        }
    }

    /// Get the index of an element with a specified identifier.
    /// - Parameter id: The element's identifier.
    /// - Returns: The index of the element.
    private func getIndex(id: Element.ID?) -> Int? {
        firstIndex { $0.id == id }
    }

}
