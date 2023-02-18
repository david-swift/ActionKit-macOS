//
//  CanvasEditorModel.swift
//  ActionKit
//
//  Created by david-swift on 08.02.23.
//

import Foundation

/// Information about an instance of the ``CanvasEditor``.
class CanvasEditorModel: ObservableObject {

    /// The rectangle for selecting nodes.
    @Published var selectionRectangle: CGRect = .zero
    /// Whether the rectangle for selecting nodes is visible.
    @Published var showSelectionRectangle = false

}
