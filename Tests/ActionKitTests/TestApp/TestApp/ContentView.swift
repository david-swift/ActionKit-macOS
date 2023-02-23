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
        FunctionEditor(
            $model.function.function,
            zoom: 1
        ) { _ in

        } extraActions: {
            TaggedView(tag: "run") {
                Button {
                    do {
                        let output = try model.function.function.run(input: ["Hello", 5, Bool.random()])
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
