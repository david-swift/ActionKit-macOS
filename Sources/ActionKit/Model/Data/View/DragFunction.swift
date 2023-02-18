//
//  DragFunction.swift
//  ActionKit
//
//  Created by david-swift on 14.02.23.
//

import Foundation

/// Information about dragging a function from the ``FunctionsView``.
struct DragFunction {

    /// The dragged function.
    var function: Function
    /// The drag position in the scroll view's coordinate space.
    var position: CGPoint
    /// Whether the user has released the function and it should be placed.
    var place = false

}
