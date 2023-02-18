//
//  NodeView.swift
//  ActionKit
//
//  Created by david-swift on 04.02.23.
//

import ColibriComponents
import SwiftUI

/// The view for a node.
struct NodeView: View {

    /// The node's function.
    @Binding var node: Node
    /// The parent function.
    @Binding var function: Function
    /// The drag gesture for a wire.
    @Binding var dragGesture: DragWire?
    /// The presentation of the actions.
    @Binding var actions: ActionVisibility
    /// The presentation of the error.
    @Binding var error: FunctionError
    /// Whether the node is selected.
    @Binding var selected: Bool
    /// The node's index.
    var id: Int
    /// The function for opening a function's definition.
    var open: ((Function) -> Void)?

    /// The view's body.
    var body: some View {
        background
            .opacity(.nodeOpacity)
            .animation(.default.speed(.selectedAnimationSpeed), value: selected)
            .overlay {
                inputPoints
                outputPoints
            }
            .freeformToolbar(visibility: selected && actions != .hidden, y: .nodeToolbarPosition(height)) {
                for item in tools {
                    ToolbarAction(.init(localized: item.title), symbol: item.icon, action: item.action)
                }
            }
            .contextMenu {
                ForEach(tools, id: \.title.key) { item in
                    Button(item.title) {
                        selected = true
                        item.action()
                    }
                }
            }
            .sheet(isPresented: (actions == .parameters && selected).binding { newValue in
                if newValue {
                    actions = .parameters
                } else {
                    actions = .hidden
                }
            }) {
                InputParametersView(
                    node: $node,
                    actions: $actions,
                    wires: $function.wires,
                    function: nodeFunction,
                    nodeID: id
                )
                    .background(.clear)
            }
            .popover(isPresented: (actions == .definition && selected).binding { newValue in
                if newValue {
                    actions = .definition
                } else {
                    actions = .hidden
                }
            }) {
                functionPopover
            }
    }

    /// The node's function.
    private var nodeFunction: Function? {
        function.allFunctions(input: []) { _ in }[id: node.function]
    }

    /// The actions for the node.
    /// They are defined with ``NodeView.Action`` so that they can be used in the custom actions view
    /// and in the context menu.
    @ArrayBuilder<Action> private var tools: [Action] {
        Action(
            title: .init("Parameters", comment: "NodeView (The name of the action for showing the parameters)"),
            icon: .init(systemSymbol: .circleFill)
        ) {
            actions = .parameters
        }
        Action(
            title: .init("Definition", comment: "NodeView (The name of the action for showing the definition)"),
            icon: .init(systemSymbol: .ellipsisCurlybraces)
        ) {
            actions = .definition
        }
        if node.function != .input && node.function != .output {
            Action(
                title: .init("Delete", comment: "NodeView (The name of the action for deleting the node)"),
                icon: .init(systemSymbol: .xmark)
            ) {
                function.allNodes = function.allNodes.filter { $0.id != node.id }
            }
        }
    }

    /// The input points view.
    private var inputPoints: some View {
        parameterPoints(nodeFunction?.input ?? [], x: .pointsPadding, output: false)
    }

    /// The output points view.
    private var outputPoints: some View {
        parameterPoints(nodeFunction?.output ?? [], x: (nodeFunction?.width ?? 0) - .pointsPadding, output: true)
    }

    /// The node's background.
    private var background: some View {
        RoundedRectangle(cornerRadius: .nodeCornerRadius)
            .frame(
                width: nodeFunction?.width ?? 0,
                height: height
            )
            .foregroundStyle(.background)
            .shadow(color: .black.opacity(.nodeShadowOpacity), radius: .shadowRadius)
            .overlay {
                if selected {
                    RoundedRectangle(cornerRadius: .nodeCornerRadius)
                        .stroke(Color.accentColor, style: .init(lineWidth: .nodeLineWidth))
                }
            }
            .overlay {
                title
                    .position(
                        x: .half(nodeFunction?.width ?? 0),
                        y: .pointsPadding
                    )
            }
    }

    /// The node's title view.
    private var title: some View {
        Text(nodeFunction?.name ?? .init())
            .lineLimit(1)
            .font(.headline)
            .geometry { geometry in
                let width = geometry.size.width
                + .normalWidth
                function.editableAllFunctions[id: node.function]?.width = width
            }
    }

    /// The height of the node view.
    private var height: CGFloat {
        Self.height(maxCount: nodeFunction?.maxCount ?? 1)
    }

    /// The popover for presenting the definition of the node's function.
    @ViewBuilder private var functionPopover: some View {
        if let nodeFunction, nodeFunction.getOutput == nil {
            FunctionEditor(nodeFunction.binding { _ in }, zoom: .functionPopoverZoom, functionsView: false)
                .frame(width: .functionPopoverSideLength, height: .functionPopoverSideLength)
            .overlay {
                if let open {
                    VStack {
                        HStack {
                            Spacer()
                            Button("Open \"\(nodeFunction.name)\"") {
                                open(nodeFunction)
                            }
                            .padding()
                        }
                        Spacer()
                    }
                }
            }
        } else {
            Text("Function defined by the developer.")
                .padding()
        }
    }

    /// An action that can be executed on the node.
    /// It is used to provide the same actions to the custom actions view and the context menu.
    private struct Action {

        /// The action's title.
        var title: LocalizedStringResource
        /// The action's image.
        var icon: Image
        /// The action.
        var action: () -> Void

    }

    /// Get the position of the parameter point at a certain index.
    /// - Parameter index: The point's index.
    /// - Returns: The position.
    static func pointPosition(index: Int) -> CGFloat {
        .pointsPadding * CGFloat(index + 1) + .paddingBetweenPoints * CGFloat(index)
    }

    /// Get the height of a node with a specified maximum number of inputs or outputs.
    /// - Parameter maxCount: The number of inputs if there are more inputs than outputs,
    /// or the number of outputs otherwise.
    /// - Returns: The node's height.
    static func height(maxCount: Int) -> CGFloat {
        pointPosition(index: maxCount) - .paddingBetweenPoints
    }

    /// Get the position of the parameter point with a certain identifier.
    /// - Parameters:
    ///   - id: The identifier.
    ///   - parameters: The parameters.
    /// - Returns: The position.
    private func pointPosition(_ id: UUID, parameters: [Parameter]) -> CGFloat {
        let index = parameters.firstIndex { $0.id == id } ?? 0
        return Self.pointPosition(index: index)
    }

    /// Draw a column of parameter points at a certain x position.
    /// - Parameters:
    ///   - parameters: The parameters in the column.
    ///   - xPos: The x value of the position of the column.
    ///   - output: Whether it is an output column for managing the dragging.
    /// - Returns: A view containing the column.
    private func parameterPoints(_ parameters: [Parameter], x xPos: CGFloat, output: Bool) -> some View {
        ForEach(parameters) { parameter in
            let position: CGPoint = .init(x: xPos, y: pointPosition(parameter.id, parameters: parameters))
            let index = parameters.firstIndex { $0.id == parameter.id } ?? 0
            let pos = FunctionEditor.outputPosition(nodePosition: node.position, function: nodeFunction, index: index)
            PointView(
                type: parameter.type,
                manuallyDefined: !output && node.values[parameters.firstIndex { $0.id == parameter.id } ?? 0] != nil
            ) { gestureValue in
                if output {
                    changeDragGesture(value: gestureValue, pos: pos, index: index)
                } else {
                    withAnimation {
                        function.wires = function.wires.filter { $0.end != (id, index) }
                    }
                }
            } endDrag: { gestureValue in
                if output {
                    endDragGesture(value: gestureValue, pos: pos, parameter: parameter)
                }
                withAnimation(.default.speed(.dragAnimationSpeed)) {
                    dragGesture = nil
                }
            }
            .position(position)
        }
    }

    /// Update the state after a change of the drag gesture.
    /// - Parameters:
    ///   - value: Information about the gesture.
    ///   - pos: The point's position.
    ///   - index: The point's index.
    private func changeDragGesture(value: DragGesture.Value, pos: CGPoint, index: Int) {
        dragGesture = .init(
            parameter: (id, index),
            position: .init(
                x: pos.x + value.location.x - .dragWireOffset,
                y: pos.y + value.location.y - .dragWireOffset
            )
        )
    }

    /// Update the state when the drag gesture ends.
    /// - Parameters:
    ///   - value: Information about the gesture.
    ///   - pos: The point's position.
    ///   - parameter: The point's parameter.
    private func endDragGesture(value: DragGesture.Value, pos: CGPoint, parameter: Parameter) {
        for (nodeIndex, node) in function.allNodes.enumerated() {
            if let function = function
                .allFunctions(input: [], output: { _ in })
                .first(where: { $0.id == node.function }) {
                for (inputIndex, inputParameter) in function.input.enumerated() {
                    let position = FunctionEditor.inputPosition(
                        nodePosition: node.position,
                        function: function,
                        index: inputIndex
                    )
                    let location = value.location.add(
                        size: .init(width: pos.x - .dragWireOffset, height: pos.y - .dragWireOffset)
                    )
                    if abs(position.x - location.x) < .endDragWireOffsetTolerance
                        && abs(position.y - location.y) < .endDragWireOffsetTolerance,
                        let dragGesture {
                        if inputParameter.type == parameter.type {
                            withAnimation(.default.speed(.dragAnimationSpeed)) {
                                let end = (nodeIndex, inputIndex)
                                self.function.wires = self.function.wires.filter { $0.end != end }
                                self.function.allNodes[safe: nodeIndex]?.values.removeValue(forKey: inputIndex)
                                self.function.wires.append(.init(from: dragGesture.parameter, to: end))
                            }
                        } else {
                            FunctionError.show(
                                error: $error,
                                newError: .typeError(type1: parameter.type, type2: inputParameter.type)
                            )
                        }
                        break
                    }
                }
            }
        }
    }

}

/// The previews for the ``NodeView``.
struct NodeView_Previews: PreviewProvider, View {

    /// The previews.
    static var previews: some View {
        Self()
    }

    /// The node for previewing the node view.
    @State private var node: Node = .init(function: "test")
    /// The functions for previewing the node view.
    @State private var functions: [Function] = [
        .init(id: "test", name: "Tests", description: "Test", input: [.init("Hello", type: String.self)])
    ]
    /// The action visibitliy for previewing the node view.
    @State private var actions: ActionVisibility = .hidden

    /// The preview view's body.
    var body: some View {
        NodeView(
            node: $node,
            function: .constant(.init(id: "", name: "", description: "")),
            dragGesture: .constant(.init(parameter: (0, 0), position: .zero)),
            actions: $actions,
            error: .constant(.noError),
            selected: .constant(false),
            id: .zero
        )
    }

}
