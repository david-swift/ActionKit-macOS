//
//  FunctionView.swift
//  ActionKit
//
//  Created by david-swift on 14.02.23.
//

import SwiftUI

/// A modifier for a draggable function representation in front of the editor.
struct FunctionView: ViewModifier {

    /// Information about dragging a function.
    @Binding var dragFunction: DragFunction?
    /// The function view's position in the global frame.
    @State private var position: CGSize = .zero
    /// The function.
    var function: Function
    /// The dragging function's offset.
    var offset: CGSize

    /// The modifier's body.
    /// - Parameter content: The content.
    /// - Returns: The view with the gesture.
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture()
                    .onChanged { gestureValue in
                        let location = gestureValue.location
                            .add(size: position)
                        dragFunction = .init(function: function, position: location)
                    }
                    .onEnded { _ in
                        dragFunction?.place = true
                    }
            )
            .geometry { geometry in
                let rect = geometry.frame(in: .global).offsetBy(dx: -offset.width, dy: -offset.height)
                position = .init(width: rect.origin.x, height: rect.origin.y)
            }
    }

}
