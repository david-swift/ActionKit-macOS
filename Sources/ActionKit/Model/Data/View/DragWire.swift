//
//  DragWire.swift
//  ActionKit
//
//  Created by david-swift on 07.02.23.
//

import Foundation

/// Information about the dragging gesture for a wire for ``FunctionEditorModel.dragWire``
struct DragWire {

    /// The node and parameter index with the wire's start position.
    var parameter: (Int, Int)
    /// The wire's end position.
    var position: CGPoint

}
