//
//  FunctionEditor+.swift
//  ActionKit
//
//  Created by david-swift on 17.02.23.
//

import SwiftUI

extension FunctionEditor {

    /// Get the position of an input point.
    /// - Parameters:
    ///   - nodePosition: The node's position.
    ///   - function: The node's function.
    ///   - index: The point's index.
    /// - Returns: The input point's position.
    static func inputPosition(nodePosition: CGPoint?, function: Function?, index: Int) -> CGPoint {
        nodePosition?.add(size: .init(
            width: .half(-(function?.width ?? 0)) + .half(.editorPadding),
            height: -.half(NodeView.height(maxCount: function?.maxCount ?? 1)) + NodeView.pointPosition(index: index)
        )) ?? .zero
    }

    /// Get the position of an output point.
    /// - Parameters:
    ///   - nodePosition: The node's position.
    ///   - function: The node's function.
    ///   - index: The point's index.
    /// - Returns: The output point's position.
    static func outputPosition(nodePosition: CGPoint?, function: Function?, index: Int) -> CGPoint {
        nodePosition?.add(size: .init(
            width: .half(function?.width ?? 0) - .half(.editorPadding),
            height: -.half(NodeView.height(maxCount: function?.maxCount ?? 1)) + NodeView.pointPosition(index: index)
        )) ?? .zero
    }

    /// The drag gesture of a node.
    /// - Parameter node: The node.
    /// - Returns: The gesture.
    private func dragGesture(node: Node) -> some Gesture {
        DragGesture()
            .onChanged { value in
                setPosition(point: value.location, node: node)
            }
            .onEnded { _ in
                for index in function.allNodes.indices {
                    withAnimation {
                        function.allNodes[safe: index]?.position.map(max: .editorSideLength)
                    }
                }
            }
    }

    /// The view layer for showing the nodes.
    /// - Parameter selectionRectangle: The seleciton rectangle.
    /// - Returns: The view layer for showing the nodes.
    func nodesView(selectionRectangle: CGRect?) -> some View {
        ForEach(function.allNodes) { node in
            nodeView(node: node)
                .position(node.position)
                .onChange(of: selectionRectangle) {
                    if let selectionRectangle {
                        if selectionRectangle.contains(node.position) {
                            model.selection.insert(node.id)
                        } else {
                            model.selection.remove(node.id)
                        }
                    }
                }
                .gesture(dragGesture(node: node))
                .simultaneousGesture(tapGesture(id: node.id, modifiers: .command))
                .simultaneousGesture(tapGesture(id: node.id, modifiers: .shift))
                .gesture(tapGesture(id: node.id))
        }
    }

    /// The view for a single node.
    /// - Parameter node: The node.
    /// - Returns: A view containing the node.
    private func nodeView(node: Node) -> some View {
        NodeView(
            node: .init {
                node
            } set: { newValue in
                function.allNodes[id: node.id] = newValue
            },
            function: $function,
            dragGesture: $model.dragWire,
            actions: .init {
                model.selection.count > 1 ? .hidden : model.actions
            } set: { newValue in
                model.actions = newValue
            },
            error: $model.error,
            selected: .init {
                model.selection.contains(node.id)
            } set: { newValue in
                if newValue {
                    model.selection = [node.id]
                }
            },
            id: nodesIndex(id: node.id) ?? 0,
            open: openNode
        )
    }

    /// A tap gesture for adding an identifier to the selection.
    /// - Parameters:
    ///   - id: The identifier.
    ///   - modifiers: The modifiers that are required.
    /// - Returns: The tap gesture with the modifiers.
    private func tapGesture(id: UUID, modifiers: EventModifiers) -> some Gesture {
        TapGesture()
            .modifiers(modifiers)
            .onEnded {
                changeSelection(id: id)
            }
    }

    /// A tap gesture for changing the selection to one node or, if already selected, toggling the actions' visibility.
    /// - Parameter id: The identifier.
    /// - Returns: The tap gesture.
    private func tapGesture(id: UUID) -> some Gesture {
        TapGesture()
            .onEnded {
                if model.selection == [id] {
                    withAnimation {
                        model.actions.toggle()
                    }
                } else {
                    model.selection = [id]
                }
            }
    }

    /// Add an identifier to or remove an identifier from the node selection.
    /// - Parameter id: The identifier.
    private func changeSelection(id: UUID) {
        if model.selection.contains(id) {
            model.selection.remove(id)
        } else {
            model.selection.insert(id)
        }
    }

    /// Get the index of the node with the specified identifier.
    /// - Parameter id: The identifier.
    /// - Returns: The node's index.
    private func nodesIndex(id: UUID) -> Int? {
        function.allNodes.firstIndex { $0.id == id }
    }

    /// Set the position of the selected nodes if one of the selected nodes is dragged.
    /// Set the position of the dragged node if it is not part of the selection.
    /// - Parameters:
    ///   - point: The new location.
    ///   - node: The dragged node.
    private func setPosition(point: CGPoint, node: Node) {
        if model.selection.contains(node.id) {
            let distances = function.allNodes.filter { model.selection.contains($0.id) }.map { selectedNode in
                let size = CGSize(
                    width: selectedNode.position.x - node.position.x,
                    height: selectedNode.position.y - node.position.y
                )
                return (selectedNode.id, size)
            }
            for id in model.selection {
                let point = point.add(size: distances.first { $0.0 == id }?.1 ?? .zero)
                function.allNodes[id: id]?.position = point
            }
        } else {
            function.allNodes[id: node.id]?.position = point
        }
    }

    /// The view layer for showing the wire that is being dragged.
    /// - Parameter context: The graphics context.
    func dragWire(context: GraphicsContext) {
        if let dragWire = model.dragWire {
            let node = function.allNodes[safe: dragWire.parameter.0]
            let function = function.editableAllFunctions[id: node?.function]
            let color = function?.output[safe: dragWire.parameter.1]?.type.color ?? .clear
            let startPosition = Self.outputPosition(
                nodePosition: node?.position,
                function: function,
                index: dragWire.parameter.1
            )
            context.addCurve(startPosition: startPosition, endPosition: dragWire.position, color: color)
        }
    }

    /// The view layer for a single wire.
    /// - Parameters:
    ///   - wire: The wire that should be displayed.
    ///   - context: The graphics context.
    /// - Returns: A view containing the wire.
    func wireView(_ wire: Wire, context: GraphicsContext) {
        let point = wire.start
        let node = function.allNodes[safe: point.0]
        let color = function.editableAllFunctions[id: node?.function]?.output[safe: point.1]?.type.color ?? .clear
        let startNode = function.allNodes[safe: wire.start.0]
        let endNode = function.allNodes[safe: wire.end.0]
        let startFunction = function.editableAllFunctions[id: startNode?.function]
        let endFunction = function.editableAllFunctions[id: endNode?.function]
        let startPosition = Self.outputPosition(
            nodePosition: startNode?.position,
            function: startFunction,
            index: wire.start.1
        )
        let endPosition = Self.inputPosition(
            nodePosition: endNode?.position,
            function: endFunction,
            index: wire.end.1
        )
        context.addCurve(startPosition: startPosition, endPosition: endPosition, color: color)
    }

    /// Get the selected nodes.
    /// - Parameter value: The value that is changed with the nodes' selection.
    /// - Returns: The new function editor with the observation of the selection.
    public func observeSelection(value: Binding<Set<UUID>>) -> Self {
        var newSelf = self
        newSelf.observeSelection = value
        return newSelf
    }

    /// Get the action's state.
    /// - Parameter value: The value that is changed with the action's state.
    /// - Returns: The new function editor with the observation of the actions' visibility.
    public func observeActions(value: Binding<ActionVisibility>) -> Self {
        var newSelf = self
        newSelf.observeActions = value
        return newSelf
    }

    /// Get the expand function's state.
    /// - Parameter value: The value that is changed with the expand function's state.
    /// - Returns: The new function editor with the observation of the expansion.
    public func observeExpandFunctions(value: Binding<Bool>) -> Self {
        var newSelf = self
        newSelf.observeExpandFunctions = value
        return newSelf
    }

    /// Throw an error as the developer by attaching a binding.
    /// - Parameters:
    ///   - error: The error.
    /// - Returns: The new function.
    public func throwError(error: Binding<String?>) -> Self {
        var newSelf = self
        newSelf.developerError = error
        return newSelf
    }

}
