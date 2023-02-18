//
//  DragFunctionView.swift
//  ActionKit
//
//  Created by david-swift on 14.02.23.
//

import SwiftUI

/// The view displaying the dragged function.
struct DragFunctionView: View {

    /// Information about the dragging.
    @Binding var dragFunction: DragFunction?
    /// The parent function.
    @Binding var function: Function
    /// The position in the scroll view.
    var scrollValue: CGPoint

    /// The view's body.
    var body: some View {
        if let dragFunction {
            GroupBox {
                Text(dragFunction.function.name)
                    .opacity(.dragFunctionOpacity)
            }
            .position(dragFunction.position)
            .onChange(of: dragFunction.place) { newValue in
                if newValue {
                    self.function.allNodes.append(
                        .init(
                            function: dragFunction.function.id,
                            position: scrollValue.add(
                                size: .init(width: dragFunction.position.x, height: dragFunction.position.y)
                            )
                        )
                    )
                    self.dragFunction = nil
                }
            }
        }
    }

}

/// Previews for the ``DragFunctionView``.
struct DragFunctionView_Previews: PreviewProvider {

    /// The side length of the preview.
    static let sideLength: CGFloat = 100

    /// The previews.
    static var previews: some View {
        DragFunctionView(
            dragFunction: .constant(.init(
                function: .init(id: "nice", name: "Nice", description: "Nice Function"),
                position: .init(x: .half(sideLength), y: .half(sideLength))
            )),
            function: .constant(.init(id: "", name: "", description: "")),
            scrollValue: .zero
        )
        .frame(width: sideLength, height: sideLength)
    }

}
