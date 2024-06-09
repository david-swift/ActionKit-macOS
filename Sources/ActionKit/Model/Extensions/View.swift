//
//  View.swift
//  ActionKit
//
//  Created by david-swift on 14.02.23.
//

import SwiftUI

extension View {

    /// The style of an action button on top of the function editor.
    /// - Returns: The view styles as an action button.
    func actionButton() -> some View {
        padding(.actionButtonPadding)
            .padding(.horizontal, .horizontalActionButtonPadding)
            .foregroundColor(.accentColor)
            .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: .nodeCornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: .nodeCornerRadius)
                    .stroke(.secondary.opacity(.actionButtonStrokeOpacity))
            }
    }

    /// A draggable function representation in front of the editor.
    /// - Parameters:
    ///   - dragFunction: Information about dragging a function.
    ///   - function: The function.
    ///   - offset: The function editor's offset in the global coordinate space.
    /// - Returns: The view with the draggable function view on top.
    func functionView(dragFunction: Binding<DragFunction?>, function: Function, offset: CGSize) -> some View {
        modifier(FunctionView(dragFunction: dragFunction, function: function, offset: offset))
    }

    /// Observe the geometry of the view.
    /// - Parameter action: Get the geometry when the view appears and whenever the geometry changes.
    /// - Returns: The view.
    public func geometry(_ action: @escaping (GeometryProxy) -> Void) -> some View {
        overlay {
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        action(geometry)
                    }
                    .onChange(of: geometry.size) {
                        action(geometry)
                    }
                    .onChange(of: geometry.safeAreaInsets) {
                        action(geometry)
                    }
                    .onChange(of: geometry.frame(in: .global)) {
                        action(geometry)
                    }
            }
        }
    }

    /// Modifies the view for a custom toolbar item.
    /// - Parameter padding: The horizontal padding of the item.
    /// - Returns: A view containing the item.
    internal func customToolbarItem(padding: Edge.Set) -> some View {
        let side = 20.0
        let paddingValue = 5.0
        return frame(width: side, height: side)
            .labelStyle(.iconOnly)
            .padding([.vertical, padding], paddingValue)
            .buttonStyle(.plain)
            .contentShape(Rectangle())
    }

    /// A toolbar in the style used in the  Freeform app.
    /// It floats over another view.
    /// https://support.apple.com/guide/freeform/welcome/mac
    /// - Parameters:
    ///   - visibility: The visibility of the toolbar.
    ///   - actions:  The toolbar actions.
    ///   - xOffset: The offset on the x axis.
    ///   - yOffset: The offset on the y axis.
    /// - Returns: A view with the toolbar.
    public func freeformToolbar(
        visibility: Bool,
        actions: [ToolbarAction],
        x xOffset: CGFloat = 0,
        y yOffset: CGFloat = 0
    ) -> some View {
        overlay {
            if visibility {
                FreeformToolbar(actions: actions)
                    .offset(x: xOffset, y: yOffset)
            }
        }
    }

}
