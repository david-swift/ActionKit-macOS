//
//  Path.swift
//  ActionKit
//
//  Created by david-swift on 08.02.23.
//
//  Thanks to AudioKit for the file:
//  "NodeEditor+Drawing.swift"
//  https://github.com/AudioKit/Flow/blob/main/Sources/Flow/Views/NodeEditor+Drawing.swift
//

import SwiftUI

extension Path {

    /// Add a wire to a path.
    /// Thanks to AudioKit for the file "NodeEditor+Drawing.swift".
    /// - Parameters:
    ///   - startPosition: The wire's start position.
    ///   - endPosition: The wire's end position.
    mutating func addCurve(startPosition: CGPoint, endPosition: CGPoint) {
        let curve = .curveMultiplier * (endPosition.x - startPosition.x)
        move(to: startPosition)
        addCurve(
            to: endPosition,
            control1: .init(x: startPosition.x + curve, y: startPosition.y),
            control2: .init(x: endPosition.x - curve, y: endPosition.y)
        )
    }

}
