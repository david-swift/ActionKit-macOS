//
//  FunctionEditor.swift
//  ActionKit
//
//  Created by david-swift on 30.01.23.
//

import ColibriComponents
import SwiftUI

/// The editor for a function.
public struct FunctionEditor: View {

    /// The type of extra actions.
    public typealias ExtraAction = TaggedView<String, Button<Label<Text, Image>>>

    /// The function that can be edited in this editor.
    @Binding public var function: Function
    /// The instance of the function editor model.
    @StateObject var model: FunctionEditorModel
    /// The function that is called when a node should be opened.
    /// If this function is ``nil``, there won't be a button for opening a node's definition.
    var openNode: ((Function) -> Void)?
    /// Additions to the actions displayed in the bottom right corner of the editor.
    /// Ideal for for example displaying a "Run" button.
    var extraActions: [ExtraAction]
    /// The selected nodes.
    var observeSelection: Binding<Set<UUID>>?
    /// The actions visibility.
    var observeActions: Binding<ActionVisibility>?
    /// The expansion of the functions view.
    var observeExpandFunctions: Binding<Bool>?
    /// An error thrown by the developer.
    var developerError: Binding<String?>?

    /// The ``FunctionEditor``'s view.
    public var body: some View {
        VStack {
            CanvasEditor(selection: $model.selection, sideLength: .editorSideLength, zoom: model.zoom) { rect in
                nodesView(selectionRectangle: rect)
                wires
            }
            .observeScroll(value: $model.scrollValue)
        }
        .overlay(alignment: .top) {
            errors
        }
        .overlay(alignment: .bottom) {
            if model.functionsView {
                FunctionsView(
                    expand: $model.expandFunctionsView,
                    dragFunction: $model.dragFunction,
                    functions: function.groupedFunctions,
                    extraActions: extraActions
                )
            }
        }
        .overlay {
            DragFunctionView(dragFunction: $model.dragFunction, function: $function, scrollValue: model.scrollValue)
        }
        .onChange(of: model.selection) { newValue in
            observeSelection?.wrappedValue = newValue
        }
        .onChange(of: observeSelection?.wrappedValue) { newValue in
            if let newValue {
                model.selection = newValue
            }
        }
        .onChange(of: model.actions) { newValue in
            observeActions?.wrappedValue = newValue
        }
        .onChange(of: observeActions?.wrappedValue) { newValue in
            if let newValue {
                model.actions = newValue
            }
        }
        .onChange(of: model.expandFunctionsView) { newValue in
            observeExpandFunctions?.wrappedValue = newValue
        }
        .onChange(of: observeExpandFunctions?.wrappedValue) { newValue in
            if let newValue {
                model.expandFunctionsView = newValue
            }
        }
        .onChange(of: developerError?.wrappedValue) { newValue in
            if let newValue {
                FunctionError.show(error: $model.error, newError: .devError(message: newValue))
            }
        }
    }

    /// The layer containing the wires.
    var wires: some View {
       ZStack {
           ForEach(function.wires) { wire in
               wireView(wire)
           }
           dragWire
       }
       .frame(width: .editorSideLength, height: .editorSideLength)
       .offset(x: -.editorPadding, y: -.editorPadding)
    }

    /// The view layer for showing the wire that is being dragged.
    @ViewBuilder var dragWire: some View {
        if let dragWire = model.dragWire {
            let node = function.allNodes[safe: dragWire.parameter.0]
            let function = function.editableAllFunctions[id: node?.function]
            let color = function?.output[safe: dragWire.parameter.1]?.type.color ?? .clear
            Path { path in
                let startPosition = Self.outputPosition(
                    nodePosition: node?.position,
                    function: function,
                    index: dragWire.parameter.1
                )
                path.addCurve(startPosition: startPosition, endPosition: dragWire.position)
            }
            .stroke(color.gradient, style: .init(lineWidth: .wireWidth))
        }
    }

    /// The view layer for showing the errors.
    var errors: some View {
        Group {
            switch model.error {
            case let .typeError(type1: type1, type2: type2):
                ErrorMessage(
                    message: .init(localized: .init(
                        "Cannot convert type \"\(type1.name)\" into type \"\(type2.name)\".",
                        comment: "FunctionEditor (Message of the type error)"
                    ))
                )
            case let .devError(message: message):
                ErrorMessage(message: message)
                    .onAppear {
                        developerError?.wrappedValue = nil
                    }
            default:
                Color.clear
                    .onAppear {
                        developerError?.wrappedValue = nil
                    }
            }
        }
        .padding()
    }

    /// The initializer for the function editor.
    /// - Parameters:
    ///   - function: The editable function as a binding.
    ///   - zoom: The zoom value.
    ///   - functionsView: Whether there is a view showing all the functions or not.
    ///   - openNode: The function for opening the definition of a node's function.
    ///   - extraActions: Buttons displayed directly above the functions view in the editor.
    public init(
        _ function: Binding<Function>,
        zoom: Double = 1,
        functionsView: Bool = true,
        openNode: ((Function) -> Void)? = nil,
        @ArrayBuilder<ExtraAction> extraActions: () -> [ExtraAction] = { [] }
    ) {
        self._function = function
        self._model = .init(wrappedValue: .init(zoom: zoom, functionsView: functionsView && zoom == 1))
        self.openNode = openNode
        self.extraActions = extraActions()
        developerError = String?.none.binding { _ in }
    }

}
