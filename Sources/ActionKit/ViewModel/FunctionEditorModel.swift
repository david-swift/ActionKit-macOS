//
//  FunctionEditorModel.swift
//  ActionKit
//
//  Created by david-swift on 06.02.23.
//

import SwiftUI

/// Information for the function editor.
class FunctionEditorModel: ObservableObject {

    /// The selected nodes.
    @Published var selection: Set<UUID> = []
    /// Information about dragging a wire.
    @Published var dragWire: DragWire?
    /// Information about dragging a function for adding into the code editor.
    @Published var dragFunction: DragFunction?
    /// Information about the displayed error.
    @Published var error: FunctionError = .noError
    /// Whether the actions are visible.
    @Published var actions: ActionVisibility = .menu
    /// The zoom, default is 1.
    @Published var zoom: Double
    /// Whether the view containing all the available functions is expanded.
    @Published var expandFunctionsView = false
    /// Whether the view containing all the available functions is displayed.
    @Published var functionsView: Bool
    /// The point in the scroll view that is at the origin of the window.
    @Published var scrollValue: CGPoint = .zero

    /// Initialize a function editor model.
    /// - Parameters:
    ///   - zoom: The zoom.
    ///   - functionsView: Whether the functions view is displayed.
    init(zoom: Double, functionsView: Bool) {
        self.zoom = zoom
        self.functionsView = functionsView
    }

}
