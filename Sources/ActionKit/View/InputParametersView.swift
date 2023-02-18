//
//  InputParametersView.swift
//  ActionKit
//
//  Created by david-swift on 08.02.23.
//

import SwiftUI

/// A view for defining parameter values manually.
struct InputParametersView: View {

    /// The node to edit.
    @Binding var node: Node
    /// The visibility of the actions.
    @Binding var actions: ActionVisibility
    /// The parent function's wires.
    @Binding var wires: [Wire]
    /// The node's function.
    var function: Function?
    /// The node's index.
    var nodeID: Int

    /// The view's body.
    var body: some View {
        Table(function?.input ?? []) {
            TableColumn("Parameter") { value in
                parameterColumn(value: value)
            }
            TableColumn("Value") { value in
                valueColumn(value: value)
            }
        }
        .frame(
            minWidth: .inputParametersViewMinWidth,
            idealWidth: .inputParametersViewIdealWidth,
            minHeight: .inputParametersViewMinHeight,
            idealHeight: .inputParametersViewIdealHeight
        )
        .toolbar {
            inputSheetToolbar
        }
    }

    /// The parameters view's toolbar.
    @ToolbarContentBuilder private var inputSheetToolbar: some ToolbarContent {
        ToolbarItem {
            VStack(alignment: .leading) {
                Text("Edit Input Parameters")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Node \"\(function?.name ?? "Unknown Function")\"")
                    .font(.headline)
            }
        }
        ToolbarItem(placement: .confirmationAction) {
            Button.confirmationButton {
                actions = .menu
            }
            .labelStyle(.titleOnly)
        }
    }

    /// The column with the parameter's name and type.
    /// - Parameter value: The parameter.
    /// - Returns: A view containing information about the parameter.
    private func parameterColumn(value: Parameter) -> some View {
        VStack(alignment: .leading) {
            Text(value.type.name)
                .foregroundColor(.secondary)
                .font(.caption)
            Text(value.name)
                .bold()
        }
    }

    /// The column with the option to toggle between the manual definition and the definition with wires
    /// and to manually define the value.
    /// - Parameter value: The parameter.
    /// - Returns: A view for editing the value.
    @ViewBuilder private func valueColumn(value: Parameter) -> some View {
        VStack(alignment: .leading) {
            Toggle("Set Manually", isOn: .init {
                setManually(index: index(parameter: value))
            } set: { newValue in
                if let index = index(parameter: value) {
                    if newValue && node.values[index] == nil {
                        node.values[index] = value.type.init()
                        let position = (nodeID, function?.input.firstIndex { $0.id == value.id } ?? 0)
                        withAnimation {
                            wires = wires.filter { $0.end != position }
                        }
                    } else if !newValue {
                        node.values.removeValue(forKey: index)
                    }
                }
            })
            value.type.pickerView(value: .init {
                if let index = index(parameter: value) {
                    return node.values[index] ?? value.type.init()
                } else {
                    return ControlFlow.noSignal
                }
            } set: { newValue in
                if let index = index(parameter: value) {
                    node.values[index] = newValue
                }
            })
            .labelsHidden()
            .padding(.horizontal, 1)
            .disabled(!setManually(index: index(parameter: value)))
        }
    }

    /// Get the index of a parameter.
    /// - Parameter parameter: A parameter.
    /// - Returns: The parameter's index.
    private func index(parameter: Parameter) -> Int? {
        function?.input.firstIndex { $0.id == parameter.id }
    }

    /// Whether the parameter at a certain index is defined manually.
    /// - Parameter index: The parameter's index.
    /// - Returns: Whether the parameter is defined manually.
    private func setManually(index: Int?) -> Bool {
        if let index {
            return node.values[index] != nil
        }
        return false
    }

}

/// Previews for the ``InputParametersView``.
struct InputParametersView_Previews: PreviewProvider, View {

    /// The previews.
    static var previews: some View {
        Self()
    }

    /// The node for testing the input parameters view.
    @State private var node = Node(function: "hi")
    /// The action visibility for testing the input parameters view.
    @State private var actions: ActionVisibility = .menu

    /// The view's body.
    var body: some View {
        InputParametersView(
            node: $node,
            actions: $actions,
            wires: .constant(.init()),
            function: .init(
                id: "hi",
                name: "Hi",
                description: "Hi",
                input: [.init("Hello", type: String.self), .init("World", type: String.self)]
            ),
            nodeID: 0
        )
    }

}
