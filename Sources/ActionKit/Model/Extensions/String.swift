//
//  String.swift
//  ActionKit
//
//  Created by david-swift on 03.02.23.
//

import SwiftUI

extension String: ActionType {

    /// The String's name for the actions.
    public static var name: String {
        .init(localized: .init("Text", comment: "String (The String's localized type name)"))
    }
    /// The String's color for the actions.
    public static var color: Color { .green }

    /// The identifier of the input function.
    static var input: Self { "david-swift.standard-actions.input" }
    /// The identifier of the output function.
    static var output: Self { "david-swift.standard-actions.output" }
    /// The identifier of the add numbers function.
    static var addNumbers: Self { "david-swift.standard-actions.add-numbers" }
    /// The identifier of the subtract numbers function.
    static var subtractNumbers: Self { "david-swift.standard-actions.subtract-numbers" }
    /// The identifier of the multiply numbers function.
    static var multiplyNumbers: Self { "david-swift.standard-actions.multiply-numbers" }
    /// The identifier of the divide numbers function.
    static var divideNumbers: Self { "david-swift.standard-actions.divide-numbers" }
    /// The identifier of the equal numbers function.
    static var equalNumbers: Self { "david-swift.standard-actions.equal-numbers" }
    /// The identifier of the greater than number function.
    static var greaterThan: Self { "david-swift.standard-actions.greater-than" }
    /// The identifier of the text conversion number function.
    static var numberToText: Self { "david-swift.standard-actions.number-to-text" }
    /// The first number in a function taking multiple numbers without a specific function.
    static var number1: Self {
        .init(
            localized: .init(
                "Number 1",
                comment: "String (The first number in a function taking mutlitple numbers without a specific function)"
            )
        )
    }
    /// The second number in a function taking multiple numbers without a specific function.
    static var number2: Self {
        .init(
            localized: .init(
                "Number 2",
                comment: "String (The second number in a function taking mutlitple numbers without a specific function)"
            )
        )
    }
    /// The number in a function taking a single number without a specific function.
    static var number: Self {
        .init(
            localized: .init(
                "Number",
                comment: "String (The number in a function taking a single number without a specific function)"
            )
        )
    }
    /// The identifier of the add text function.
    static var addText: Self { "david-swift.standard-actions.add-text" }
    /// The identifier of the equal text function.
    static var equalText: Self { "david-swift.standard-actions.equal-text" }
    /// The identifier of the text to number function.
    static var textToNumber: Self { "david-swift.standard-actions.text-to-number" }
    /// The first text in a function taking multiple text snippets without a specific function.
    static var text1: Self {
        .init(
            localized: .init(
                "Text 1",
                comment:
                    "String (The first text in a function taking multiple text snippets without a specific function)"
            )
        )
    }
    /// The second text in a function taking multiple text snippets without a specific function.
    static var text2: Self {
        .init(
            localized: .init(
                "Text 2",
                comment:
                    "String (The second text in a function taking multiple text snippets without a specific function)"
            )
        )
    }
    /// The text in a function taking a single text snippet without a specific function.
    static var text: Self {
        .init(
            localized: .init(
                "Text",
                comment:
                    "String (The text in a function taking a single text snippet without a specific function)"
            )
        )
    }
    /// The identifier of the and boolean function.
    static var and: Self { "david-swift.standard-actions.and" }
    /// The identifier of the or boolean function.
    static var orOperator: Self { "david-swift.standard-actions.or" }
    /// The identifier of the not boolean function.
    static var not: Self { "david-swift.standard-actions.not" }
    /// The identifier of the boolean to control flow function.
    static var booleanToControlFlow: Self { "david-swift.standard-actions.boolean-to-control-flow" }
    /// The first boolean in a function taking multiple booleans without a specific function.
    static var boolean1: Self {
        .init(
            localized: .init(
                "Boolean 1",
                comment:
                    "String (The first boolean in a function taking multiple booleans without a specific function)"
            )
        )
    }
    /// The second boolean in a function taking multiple booleans without a specific function.
    static var boolean2: Self {
        .init(
            localized: .init(
                "Boolean 2",
                comment:
                    "String (The second boolean in a function taking multiple booleans without a specific function)"
            )
        )
    }
    /// The boolean in a function taking a single boolean without a specific function.
    static var boolean: Self {
        .init(
            localized: .init(
                "Boolean",
                comment:
                    "String (The boolean in a function taking a single boolean without a specific function)"
            )
        )
    }
    /// The result of a comparison in a function.
    static var comparison: Self {
        .init(localized: .init("Comparison", comment: "String (The result of a comparison in a function)") )
    }
    /// The identifier of the control flow to boolean function.
    static var controlFlowToBoolean: Self { "david-swift.standard-actions.control-flow-to-boolean" }
    /// The control flow in a function taking a single control flow without a specific function.
    static var controlFlow: Self {
        .init(localized: .init(
            "Control Flow",
            comment: "String (The control flow in a function taking a single control flow without a specific function)"
        ))
    }
    /// The first generic type name in a function taking multiple values of that type without a specific function.
    static var value1: Self {
        .init(
            localized: .init(
                "Value 1",
                comment:
                    "String (The first type name in a function with multiple values of that type)"
            )
        )
    }
    /// The second generic type name in a function taking multiple values of that type without a specific function.
    static var value2: Self {
        .init(
            localized: .init(
                "Value 2",
                comment:
                    "String (The second type name in a function with multiple values of that type)"
            )
        )
    }
    /// The generic type name in a function taking a single value of that type without a specific function.
    static var value: Self {
        .init(
            localized: .init(
                "Value",
                comment:
                    "String (The second type name in a function with a single valus of that type)"
            )
        )
    }

    /// A text field for changing a text value.
    /// - Parameter value: The text.
    /// - Returns: A view containing the text field.
    public static func picker(value: Binding<ActionType>) -> any View {
        TextField("Text", text: value.get(default: ""))
    }

}
