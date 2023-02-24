//
//  PointView.swift
//  ActionKit
//
//  Created by david-swift on 05.02.23.
//

import SwiftUI

/// The view of a single parameter of a node.
struct PointView: View {

    /// Whether the parameter is hovered.
    @State private var hover = false
    /// The parameter's type.
    var type: ActionType.Type
    /// Whether the parameter is defined manually.
    var manuallyDefined: Bool
    /// This function is called when the drag gesture changes.
    var drag: (DragGesture.Value) -> Void
    /// This function is called when the drag gesture ends.
    var endDrag: (DragGesture.Value) -> Void

    /// Whether the size of the parameter's point is smaller than the standard.
    var scale: Bool {
        manuallyDefined && !hover
    }

    /// The view's body.
    var body: some View {
        Circle()
            .frame(
                width: scale ? .parameterSmallSideLength : .parameterLargeSideLength,
                height: scale ? .parameterSmallSideLength : .parameterLargeSideLength
            )
            .animation(.default, value: scale)
            .foregroundStyle(type.color.gradient)
            .background {
                Circle()
                    .frame(width: .hoverIndicatorSideLength, height: .hoverIndicatorSideLength)
                    .fixedSize()
                    .foregroundColor(.secondary.opacity(hover ? .hoverIndicatorOpacity : 0))
            }
            .onHover { hover = $0 }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        drag(value)
                    }
                    .onEnded { value in
                        endDrag(value)
                    }
            )
    }

}

/// Previews for the ``PointView``.
struct PointView_Previews: PreviewProvider {

    /// The previews.
    static var previews: some View {
        PointView(type: String.self, manuallyDefined: false) { _ in } endDrag: { _ in }
    }

}
