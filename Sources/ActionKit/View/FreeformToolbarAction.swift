//
//  FreeformToolbarAction.swift
//  ActionKit
//
//  Created by david-swift on 06.02.23.
//

import SwiftUI

/// The view of an action in the Freeform toolbar.
struct FreeformToolbarAction: View {

    /// Whether the action is hovered.
    @State private var hover = false
    /// The toolbar action.
    var action: ToolbarAction

    /// The icon's foreground color.
    var foregroundColor: AnyShapeStyle {
        let opacity = 0.7
        let color = action.isOn ? Color.accentColor : .primary.opacity(opacity)
        return .init(color.gradient)
    }

    /// The view's body.
    var body: some View {
        Button {
            action.action()
        } label: {
            let side = 22.0
            let opacity = 0.1
            Circle()
                .frame(width: side, height: side)
                .foregroundColor(.secondary.opacity(hover ? opacity : 0))
                .overlay {
                    let side = 13.0
                    action.icon
                        .frame(width: side, height: side)
                        .foregroundStyle(foregroundColor)
                }
        }
        .buttonStyle(.plain)
        .onHover { hover = $0 }
        .help(action.title)
    }

    /// Initialize a Freeform toolbar action view.
    /// - Parameter action: The action.
    init(_ action: ToolbarAction) {
        self.action = action
    }

}

/// Previews for the ``FreeFormToolbarAction``.
struct FreeFormToolbarAction_Previews: PreviewProvider {

    /// The previews.
    static var previews: some View {
        FreeformToolbarAction(
            .init(
                "Test",
                symbol: .init(systemName: "return")
            ) { }
        )
    }

}
