//
//  Double.swift
//  ActionKit
//
//  Created by david-swift on 03.02.23.
//
//  swiftlint:disable no_magic_numbers

import SwiftUI

extension Double: ActionType {

    /// The Double's name for the actions.
    public static var name: String { .init(localized: .init("Number", comment: "Double (Localized name of double)"))  }
    /// The Double's color for the actions.
    public static var color: Color { .orange }

    /// The opacity of a node background.
    internal static var nodeOpacity: Self { 0.75 }
    /// The speed of the selection animation of a node.
    internal static var selectedAnimationSpeed: Self { 2 }
    /// The opacity of a node's shadow.
    static var nodeShadowOpacity: Self { 0.3 }
    /// The opacity of the selection rectangle.
    static var selectionRectangleOpacity: Self { 0.2 }
    /// The opacity of a dot in the background of a canvas editor.
    static var backgroundDotOpacity: Self { 0.5 }
    /// The opacity of the name of the dragged function.
    static var dragFunctionOpacity: Self { 0.5 }
    /// The speed of the animation in ``ErrorMessage``.
    static var errorMessageAnimationSpeed: Self { 0.6 }
    /// The maximum scale effect of the icon in ``ErrorMessage``.
    static var errorMessageIconScaleEffect: Self { 1.4 }
    /// Seconds to display an error message to the user.
    static var displayError: Self { 5 }
    /// The zoom value of the function definition popover of a node.
    static var functionPopoverZoom: Self { 0.3 }
    /// The speed of animations that have to do with the dragging gesture.
    static var dragAnimationSpeed: Self { 3 }
    /// The opacity of the hover indicator in a parmater's view.
    static var hoverIndicatorOpacity: Self { 0.1 }
    /// The opacity of the stroke around an action button.
    static var actionButtonStrokeOpacity: Self { 0.1 }

    /// A text field for choosing a ``Double`` value.
    /// - Parameter value: The binded value.
    /// - Returns: A view containing the text field.
    public static func picker(value: Binding<ActionType>) -> any View {
        TextField(
            String(localized: .init("Number", comment: "Double (Name of double text field)")),
            value: value.get(default: 0),
            format: .number
        )
    }

}
