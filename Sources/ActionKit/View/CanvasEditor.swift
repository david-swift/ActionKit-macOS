//
//  CanvasEditor.swift
//  ActionKit
//
//  Created by david-swift on 08.02.23.
//

import SwiftUI

/// A two dimensional scroll view with a dotted background, a selection rectangle and items defined by the developer.
public struct CanvasEditor<Item>: View where Item: View {

    /// Information about the canvas editor.
    @StateObject private var model = CanvasEditorModel()
    /// The selected items.
    @Binding var selection: Set<UUID>
    /// The scroll position.
    @State private var scrollPosition: Int?
    /// The items with the selection rectangle as a parameter.
    var items: (CGRect?) -> Item
    /// The editor's side length.
    var sideLength: CGFloat
    /// The zoom value.
    var zoom: Double
    /// Observes the scroll position.
    var scrollFactor: Binding<CGPoint>?
    /// The identifier of the coordinate space for observing the scroll position.
    let coordinateSpace = UUID()

    /// The view's body.
    public var body: some View {
        ScrollView([.horizontal, .vertical]) {
            ZStack {
                selectionRectangle
                background
                items(model.showSelectionRectangle ? model.selectionRectangle : nil)
                let width = 900.0
                let height = 400.0
                Text(String())
                    .frame(width: width, height: height)
                    .opacity(0)
                    .id(0)
            }
            .geometry { geometry in
                let rect = geometry.frame(in: .named(coordinateSpace))
                scrollFactor?.wrappedValue = .init(x: -rect.origin.x, y: -rect.origin.y)
            }
            .scaleEffect(zoom)
        }
        .coordinateSpace(name: coordinateSpace)
        .scrollPosition(id: $scrollPosition)
        .task {
            scrollPosition = 0
        }
    }

    /// The view of the rectangle for selecting items.
    @ViewBuilder private var selectionRectangle: some View {
        RoundedRectangle(cornerRadius: .selectionRectangleCornerRadius)
            .path(in: model.selectionRectangle.standardized)
            .foregroundColor(.secondary.opacity(model.showSelectionRectangle ? .selectionRectangleOpacity : 0))
    }

    /// The dots in the editor's background.
    private var background: some View {
        Canvas(opaque: false) { context, _ in
            drawBackground(context: context)
        }
        .frame(width: sideLength, height: sideLength)
        .fixedSize()
        .padding(.editorPadding)
        .onTapGesture {
            selection = []
        }
        .accessibilityAddTraits(.isButton)
        .simultaneousGesture(selectionRectangleGesture)
    }

    /// The gesture for showing the selection rectangle.
    private var selectionRectangleGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                model.showSelectionRectangle = true
                model.selectionRectangle = .init(origin: value.startLocation, size: value.translation)
            }
            .onEnded { _ in
                withAnimation {
                    model.showSelectionRectangle = false
                }
            }
    }

    /// Initialize a two dimensional scroll view
    /// with a dotted background, a selection rectangle and items defined by the developer.
    /// - Parameters:
    ///   - selection: The selected items. Is cleared when the user clicks the background.
    ///   - sideLength: The editor's side length.
    ///   - zoom: The zoom value. Default is 1.
    ///   - items: The items displayed in the editor.
    public init(
        selection: Binding<Set<UUID>>,
        sideLength: CGFloat,
        zoom: Double = 1,
        @ViewBuilder items: @escaping (CGRect?) -> Item
    ) {
        self._selection = selection
        self.items = items
        self.sideLength = sideLength
        self.zoom = zoom
    }

    /// Draw the background in a provided graphics context.
    /// - Parameter context: The graphics context that should contain the background.
    private func drawBackground(context: GraphicsContext) {
        let numberOfDots = Int(Int(sideLength) / .backgroundDotPaddingDivisor)
        for xPos in 0...numberOfDots {
            for yPos in 0...numberOfDots {
                let circle = Circle().path(
                    in: .init(
                        x: xPos * .backgroundDotPaddingDivisor,
                        y: yPos * .backgroundDotPaddingDivisor,
                        width: .backgroundDotSideLength,
                        height: .backgroundDotSideLength
                    )
                )
                context.fill(circle, with: .style(.tertiary.opacity(.backgroundDotOpacity)))
            }
        }
    }

    /// Observe the scroll factor of the canvas editor.
    /// - Parameter value: The scroll factor.
    /// - Returns: A new canvas editor with the scroll factor observed.
    public func observeScroll(value: Binding<CGPoint>) -> Self {
        var newSelf = self
        newSelf.scrollFactor = value
        return newSelf
    }

}

/// Previews for the ``CanvasEditor``.
struct CanvasEditor_Previews: PreviewProvider {

    /// The previews.
    static var previews: some View {
        CanvasEditor(selection: .constant([]), sideLength: .editorSideLength) { _ in }
    }

}
