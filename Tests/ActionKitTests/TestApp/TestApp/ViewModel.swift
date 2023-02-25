//
//  ViewModel.swift
//  ActionKit
//
//  Created by david-swift on 23.02.23.
//

import ActionKit
import ColibriComponents
import Foundation

/// An example view model.
class ViewModel: ObservableObject {

    /// The example codable function.
    @Published var function: CodableFunction<Information> {
        didSet {
            let data = try? JSONEncoder().encode(function)
            if let data {
                UserDefaults.standard.set(data, forKey: "function")
            }
        }
    }
    /// The example error.
    @Published var error: String?

    /// The view model's initializer.
    init() {
        function = .init(
            id: "hi",
            name: "Hi",
            description: "A test function",
            input: [.init("Hello", type: String.self)],
            output: [.init("World", type: String.self)]
        )
        let data = UserDefaults.standard.value(forKey: "function") as? Data
        guard let data else {
            return
        }
        let decoded = try? JSONDecoder().decode(CodableFunction<Information>.self, from: data)
        guard let decoded else {
            return
        }
        function = decoded
    }

    /// An example codable function information.
    struct Information: CodableFunctionInformation {

        /// The function's types.
        static var types: [ActionType.Type] {
            String.self
            Double.self
            Bool.self
        }

        /// The available functions.
        static var functions: [Folder<Function>] {
            for group in [Folder<Function>].default { group }
            Folder<Function>("Print", icon: .init(systemSymbol: .textJustify)) {
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
        }

        /// The value of a information instance.
        var type: ActionKit.ActionType

        /// Initialize an information instance.
        /// - Parameter type: The value.
        init(type: ActionKit.ActionType) {
            self.type = type
        }

        /// Decode the information value.
        /// - Parameter decoder: The decoder.
        init(from decoder: Decoder) throws {
            let decoder = try decoder.singleValueContainer()
            if let value = try? decoder.decode(String.self) {
                self.init(type: value)
            } else if let value = try? decoder.decode(Double.self) {
                self.init(type: value)
            } else if let value = try? decoder.decode(Bool.self) {
                self.init(type: value)
            } else {
                self.init(type: try decoder.decode(ControlFlow.self))
            }
        }

        /// Encode the information value.
        /// - Parameter encoder: The encoder.
        func encode(to encoder: Encoder) throws {
            var encoder = encoder.singleValueContainer()
            if let string = type as? String {
                try encoder.encode(string)
            } else if let double = type as? Double {
                try encoder.encode(double)
            } else if let boolean = type as? Bool {
                try encoder.encode(boolean)
            } else if let controlFlow = type as? ControlFlow {
                try encoder.encode(controlFlow)
            }
        }

    }

}
