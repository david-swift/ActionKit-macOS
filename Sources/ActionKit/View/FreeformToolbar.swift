//
//  FreeformToolbar.swift
//  ActionKit
//
//  Created by david-swift on 09.06.24.
//

import SwiftUI

/// A toolbar in the style used in the  Freeform app.
/// https://support.apple.com/guide/freeform/welcome/mac
struct FreeformToolbar: View {

    /// The actions in the toolbar.
    var actions: [ToolbarAction]

    /// The view's body.
    var body: some View {
        let padding = 9.0
        HStack {
            ForEach(actions) { action in
                let padding = -4.0
                FreeformToolbarAction(action)
                    .padding(padding)
            }
        }
        .padding(padding)
        .background {
            let opacity = 0.5
            let radius = 15.0
            let yOffset = 10.0
            Capsule(style: .continuous)
                .foregroundStyle(.bar)
                .shadow(
                    color: .init(nsColor: .shadowColor).opacity(opacity),
                    radius: radius,
                    y: yOffset
                )
        }
    }

    /// Initialize a new toolbar.
    /// - Parameter actions: The toolbar actions.
    init(actions: [ToolbarAction]) {
        self.actions = actions
    }

}

/// Previews for the ``FreeformToolbar``.
struct FreeformToolbar_Previews: PreviewProvider {

    /// The previews.
    static var previews: some View {
        Text(.init())
            .padding()
            .padding()
            .freeformToolbar(visibility: true, actions: [
                .init("Hello", symbol: .init(systemName: "return")) {
                    print("Hello")
                }
                .isOn(true),
                .init("World", symbol: .init(systemName: "function")) {
                    print("World")
                },
                .init("Nice", symbol: .init(systemName: "circle.fill")) {
                    print("Nice")
                }
            ])
    }

}
