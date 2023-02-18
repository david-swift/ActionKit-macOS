//
//  Bool.swift
//  ActionKit
//
//  Created by david-swift on 14.02.23.
//

import SwiftUI

extension Bool: ActionType {

    /// The name of the boolean type.
    public static var name: String {
        .init(localized: .init("Boolean", comment: "Bool (Name of bool as an action type)") )
    }
    /// The boolean's color.
    public static var color: Color { .indigo }

    /// The localized names for the Boolean values.
    internal var localized: LocalizedStringResource {
        if self {
            return .init("True", comment: "Bool (Name of the boolean's true value)")
        }
        return .init("False", comment: "Bool (Name of the boolean's false value)")
    }

    /// A function for getting the picker for a boolean.
    /// - Parameter value: The selected boolean.
    /// - Returns: The picker view.
    public static func picker(value: Binding<ActionType>) -> any View {
        Picker(
            .init("Boolean", comment: "Bool (Label of the picker for selecting a boolean)"),
            selection: value.get(default: false)
        ) {
            ForEach([true, false], id: \.hashValue) { bool in
                Text(bool.localized)
                    .tag(bool)
            }
        }
    }

}
