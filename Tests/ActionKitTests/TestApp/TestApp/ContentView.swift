//
//  ContentView.swift
//  ActionKit
//
//  Created by david-swift on 04.02.23.
//
//  swiftlint:disable no_magic_numbers

import ActionKit
import ColibriComponents
import SwiftUI

/// The test app's content.
struct ContentView: View {

    /// The view model.
    @StateObject private var model = ViewModel()

    /// The view's body.
    var body: some View {
        UndoProvider($model.function) { $function in
            HSplitView {
                Form {
                    parameterEditor(function: $function)
                }
                editor(function: $function)
            }
        }
    }

    /// An editor for the input and output parameters.
    /// - Parameter function: The function.
    /// - Returns: A view containing the editor.
    @ViewBuilder private func parameterEditor(function: Binding<CodableFunction<ViewModel.Information>>) -> some View {
        List(function.wrappedValue.function.dataInput) { input in
            Text("\(input.name) (\(input.type.name))")
                .contextMenu {
                    Button("Delete" as String, role: .destructive) {
                        function.wrappedValue.function.input = function.wrappedValue.function.input
                            .filter { $0.id != input.id }
                    }
                }
        }
        .contextMenu {
            Button("Add" as String) {
                let random = Int.random(in: 0...2)
                function.wrappedValue.function.input.append(Parameter("New Parameter", type: {
                    switch random {
                    case 0:
                        return String.self
                    case 1:
                        return Double.self
                    default:
                        return Bool.self
                    }
                }()))
            }
        }
        List(function.wrappedValue.function.dataOutput) { output in
            Text("\(output.name) (\(output.type.name))")
                .contextMenu {
                    Button("Delete" as String, role: .destructive) {
                        function.wrappedValue.function.output = function.wrappedValue.function.output
                            .filter { $0.id != output.id }
                    }
                }
        }
        .contextMenu {
            Button("Add" as String) {
                let random = Int.random(in: 0...2)
                function.wrappedValue.function.output.append(Parameter("New Parameter", type: {
                    switch random {
                    case 0:
                        return String.self
                    case 1:
                        return Double.self
                    default:
                        return Bool.self
                    }
                }()))
            }
        }
    }

    /// An editor for the function.
    /// - Parameter function: The function.
    /// - Returns: A view containing the editor.
    private func editor(function: Binding<CodableFunction<ViewModel.Information>>) -> some View {
        FunctionEditor(
            function.function,
            zoom: 1
        ) { _ in

        } extraActions: {
            TaggedView(tag: "run") {
                Button {
                    do {
                        let input: [ActionType] = function.wrappedValue.function.dataInput.map { parameter in
                            switch parameter.type.name {
                            case "Text":
                                return "Some Text"
                            case "Number":
                                return Double.random(in: 0...10)
                            default:
                                return Bool.random()
                            }
                        }
                        let output = try function.wrappedValue.function.run(input: input)
                        for outputItem in output {
                            print(outputItem)
                        }
                        print("\n")
                    } catch {
                        if let error = error as? Function.ExecutionError {
                            switch error {
                            case .emptyIteration:
                                model.error = "Empty Iteration"
                            }
                        }
                    }
                } label: {
                    Label("Run" as String, systemSymbol: .playFill)
                }
            }
        }
        .throwError(error: $model.error)
    }
}
