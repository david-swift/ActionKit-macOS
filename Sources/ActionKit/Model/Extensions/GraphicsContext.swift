//
//  GraphicsContext.swift
//  ActionKit
//
//  Created by david-swift on 24.02.23.
//

import SwiftUI

extension GraphicsContext {

    /// Add a wire to the graphics context.
    /// - Parameters:
    ///   - startPosition: The wire's start position.
    ///   - endPosition: The wire's end position.
    ///   - color: The wire's color.
    func addCurve(startPosition: CGPoint, endPosition: CGPoint, color: Color) {
        var path = Path()
        path.addCurve(startPosition: startPosition, endPosition: endPosition)
        self.stroke(path, with: .color(color), lineWidth: .wireWidth)
    }

}
