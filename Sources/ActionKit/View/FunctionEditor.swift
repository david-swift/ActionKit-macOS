//
//  FunctionEditor.swift
//  ActionKit
//
//  Created by david-swift on 30.01.23.
//

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
                    .allowsHitTesting(false)
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
        .onChange(of: model.selection) {
            observeSelection?.wrappedValue = model.selection
        }
        .onChange(of: observeSelection?.wrappedValue) {
            if let selection = observeSelection?.wrappedValue {
                model.selection = selection
            }
        }
        .onChange(of: model.actions) {
            observeActions?.wrappedValue = model.actions
        }
        .onChange(of: observeActions?.wrappedValue) {
            if let observeActions = observeActions?.wrappedValue {
                model.actions = observeActions
            }
        }
        .onChange(of: model.expandFunctionsView) {
            observeExpandFunctions?.wrappedValue = model.expandFunctionsView
        }
        .onChange(of: observeExpandFunctions?.wrappedValue) {
            if let observeExpandFunctions = observeExpandFunctions?.wrappedValue {
                model.expandFunctionsView = observeExpandFunctions
            }
        }
        .onChange(of: developerError?.wrappedValue) {
            if let error = developerError?.wrappedValue {
                FunctionError.show(error: $model.error, newError: .devError(message: error))
            }
        }
    }

    /// The layer containing the wires.
    var wires: some View {
        Canvas(opaque: false) { context, _ in
            for wire in function.wires {
                wireView(wire, context: context)
           }
            dragWire(context: context)
        }
       .frame(width: .editorSideLength, height: .editorSideLength)
       .offset(x: -.editorPadding, y: -.editorPadding)
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
    ///   - extraActions: Buttons displayed directly above the functions view in the editor.
    ///   - openNode: The function for opening the definition of a node's function.
    public init(
        _ function: Binding<Function>,
        zoom: Double = 1,
        functionsView: Bool = true,
        extraActions: [ExtraAction] = [],
        openNode: ((Function) -> Void)? = nil
    ) {
        self._function = function
        self._model = .init(wrappedValue: .init(zoom: zoom, functionsView: functionsView && zoom == 1))
        self.openNode = openNode
        self.extraActions = extraActions
        developerError = nil
    }

}
