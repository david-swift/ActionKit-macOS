//
//  View.swift
//  ActionKit
//
//  Created by david-swift on 14.02.23.
//

import SwiftUI

extension View {

    /// The style of an action button on top of the function editor.
    /// - Returns: The view styles as an action button.
    func actionButton() -> some View {
        padding(.actionButtonPadding)
            .padding(.horizontal, .horizontalActionButtonPadding)
            .foregroundColor(.accentColor)
            .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: .nodeCornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: .nodeCornerRadius)
                    .stroke(.secondary.opacity(.actionButtonStrokeOpacity))
            }
    }

    /// A draggable function representation in front of the editor.
    /// - Parameters:
    ///   - dragFunction: Information about dragging a function.
    ///   - function: The function.
    /// - Returns: The view with the draggable function view on top.
    func functionView(dragFunction: Binding<DragFunction?>, function: Function) -> some View {
        modifier(FunctionView(dragFunction: dragFunction, function: function))
    }

}
