//
//  CGFloat.swift
//  ActionKit
//
//  Created by david-swift on 06.02.23.
//
//  swiftlint:disable no_magic_numbers

import Foundation

extension CGFloat {

    /// The side length of the function editor.
    static var editorSideLength: Self { 2_000 }
    /// The padding around a canvas editor.
    static var editorPadding: Self { 30 }
    /// Half of the editor's side length.
    static var halfEditorSideLength: Self { .half(.editorSideLength) }
    /// The x offset of the standard node position.
    static var standardNodePositionXOffset: Self { 300 }
    /// The y offset of the standard node position.
    static var standardNodePositionYOffset: Self { 50 }
    /// The padding value of a node used for limiting the freedom of movement of a node.
    static var nodePaddingValue: Self { 50 }
    /// A value for calculating the curve of a node.
    static var curveMultiplier: Self { 0.4 }
    /// The width of a wire.
    static var wireWidth: Self { 2 }
    /// A random position for a default node.
    public static var randomPosition: Self { .random(in: 800...1_200) }
    static var pointsPadding: Self { 20 }
    /// The corner radius of nodes and action buttons.
    static var nodeCornerRadius: Self { 20 }
    /// The radius of shadows in the whole project.
    static var shadowRadius: Self { 20 }
    /// The line width of the line around a node.
    static var nodeLineWidth: Self { 4 }
    /// The width of the parameter's section in a node.
    static var normalWidth: Self { 90 }
    /// The padding between parameter points.
    static var paddingBetweenPoints: Self { 5 }
    /// The corner radius of the selection rectangle.
    static var selectionRectangleCornerRadius: Self { 5 }
    /// The font size of the smallest value of the icon in ``ErrorMessage``.
    static var errorMessageIconFontSize: Self { 20 }
    /// The corner radius of ``ErrorMessage``.
    static var errorMessageCornerRadius: Self { 10 }
    /// The padding of the header of a function group in the expanded functions view.
    static var functionGroupLabelPadding: Self { 3 }
    /// The window's height is multiplied with this factor to get the expanded functions view's height.
    static var expandedFunctionsViewHeight: Self { 0.4 }
    /// The padding between a function's name and the background.
    static var compactViewInnerPadding: Self { 5 }
    /// The padding between the compact functions view and the scroll view.
    static var compactViewPadding: Self { 10 }
    /// The compact functions view's height.
    static var compactViewHeight: Self { 55 }
    /// The minimum width of the ``InputParametersView``.
    static var inputParametersViewMinWidth: Self { 200 }
    /// The ideal width of the ``InputParametersView``.
    static var inputParametersViewIdealWidth: Self { 280 }
    /// The minimum height of the ``InputParametersView``.
    static var inputParametersViewMinHeight: Self { 100 }
    /// The ideal height of the ``InputParametersView``.
    static var inputParametersViewIdealHeight: Self { 230 }
    /// The side length of the function popover for a node's definition.
    static var functionPopoverSideLength: Self { 200 }
    /// The offset of a wire that is dragged.
    static var dragWireOffset: Self { 10 }
    /// The tolerance of the distance to a node's center to make it still connect.
    static var endDragWireOffsetTolerance: Self { 10 }
    /// The side length if a parameter is not hovered and defined manually.
    static var parameterSmallSideLength: Self { 10 }
    /// The standard side length of a parameter.
    static var parameterLargeSideLength: Self { 15 }
    /// The side length of the hover indicator of a parameter.
    static var hoverIndicatorSideLength: Self { 25 }
    /// The padding inside an action button's rectangle.
    static var actionButtonPadding: Self { 5 }
    /// The horizontal padding inside an action button's rectangle added to the ``actionButtonPadding``.
    static var horizontalActionButtonPadding: Self { 10 }
    /// The padding of a divider in the compact functions view.
    static var functionsViewDividerPadding: Self { 8 }

    /// Get half of the provided number.
    /// - Parameter number: The number.
    /// - Returns: Half of the number.
    static func half(_ number: Self) -> Self {
        number / 2
    }
    /// The freeform toolbar's position of a node.
    /// - Parameter height: The node's height.
    /// - Returns: The freeform toolbar's position relative to the node.
    static func nodeToolbarPosition(_ height: Self) -> Self {
        half(height) + 25
    }

}
