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

    /// An example function.
    @State private var function = Function(
        id: "hi",
        name: "Hi",
        description: "A test function",
        input: [
            .init("String", type: String.self),
            .init("Double", type: Double.self),
            .init("Boolean", type: Bool.self)
        ], output: [
            .init("Output", type: String.self)
        ],
        functions: .default + [
            .init("Print", icon: .init(systemSymbol: .textJustify)) {
                .init(
                    id: "print",
                    name: "Print",
                    description: "Print a text into the developer's console.",
                    input: [.init("Text", type: String.self)]
                ) { input in
                    print(input.first as? String ?? "-")
                    return []
                }
            }
        ]
    )
    /// An example error.
    @State private var error: String?

    /// The view's body.
    var body: some View {
        FunctionEditor(
            $function,
            zoom: 1
        ) { _ in

        } extraActions: {
            TaggedView(tag: "run") {
                Button {
                    do {
                        let output = try function.run(input: ["Hello", 5, Bool.random()])
                        for outputItem in output {
                            print(outputItem)
                        }
                        print("\n")
                    } catch {
                        if let error = error as? Function.ExecutionError {
                            switch error {
                            case .emptyIteration:
                                self.error = "Empty Iteration"
                            }
                        }
                    }
                } label: {
                    Label("Run" as String, systemSymbol: .playFill)
                }
            }
        }
        .throwError(error: $error)
    }
}
