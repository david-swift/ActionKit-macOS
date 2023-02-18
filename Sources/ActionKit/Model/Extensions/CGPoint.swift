//
//  CGPoint.swift
//  ActionKit
//
//  Created by david-swift on 04.02.23.
//

import ColibriComponents
import Foundation

extension CGPoint {

    /// Map a CGPoint in a certain range for limiting the freedom of movement of a node.
    /// - Parameter maxValue: The maximum value.
    mutating func map(max maxValue: CGFloat) {
        let maxValue = maxValue - .nodePaddingValue
        x.map(in: .nodePaddingValue...maxValue)
        y.map(in: .nodePaddingValue...maxValue)
    }

    /// Add a ``CGSize`` to a ``CGPoint``.
    /// - Parameter size: The size to add.
    /// - Returns: The new point with the size added.
    func add(size: CGSize) -> Self {
        .init(x: x + size.width, y: y + size.height)
    }

}
