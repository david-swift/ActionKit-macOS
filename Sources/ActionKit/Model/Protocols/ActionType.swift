//
//  ActionType.swift
//  ActionKit
//
//  Created by david-swift on 29.01.23.
//

import SwiftUI

/// A type that can be used in the actions.
public protocol ActionType: Codable {

    /// The description of the action type that the user can see.
    static var name: String { get }
    /// The color of the connections of that type.
    static var color: Color { get }
    /// A standard value.
    init()
    /// The view for picking a value. It is used in the parameters view of a node.
    /// This view should look well even in a small frame.
    /// - Parameter value: The picked value.
    /// - Returns: The picker view.
    @ViewBuilder
    static func picker(value: Binding<ActionType>) -> any View

}

extension ActionType {

    /// A function for merging two control or data flows.
    /// It is interpreted as a special function where only one of the inputs has to be a value.
    public static var mergeFlowFunction: Function {
        var function = Function(
            id: "merge-\(name)",
            name: .init(localized: .init("Merge (\(name))", comment: "ActionType (The name of the merge function)")),
            description: .init(localized: .init(
                "Merge two separate flows by taking the value that is first available.",
                comment: "ActionType (Description of the unify function)"
            )),
            input: [.init(.value1, type: Self.self), .init(.value2, type: Self.self)],
            output: [.init(.value, type: Self.self)]
        ) { [$0.first as? Self ?? .init()] }
        function.requireOnlyOneInput = true
        return function
    }

    /// The picker view as an ``AnyView``.
    /// - Parameter value: The picked value.
    /// - Returns: The picker view as an ``AnyView``.
    static func pickerView(value: Binding<ActionType>) -> AnyView {
        .init(
            picker(value: value)
        )
    }

}
