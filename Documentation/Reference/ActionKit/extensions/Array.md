**EXTENSION**

# `Array`
```swift
extension Array where Element == Folder<Function>
```

## Properties
### `controlFlowFunctions`

```swift
public static let controlFlowFunctions: Self =
    [
        .init(
            .init(
                localized: .init(
                    "Convert Control Flow",
                    comment: "Array (The localized name of the conversion set in the control flow functions)"
                )
            ),
            icon: .init(systemSymbol: .arrowRight)
        ) {
            for function in controlFlowConversionFunctions { function }
        }
    ]
```

A set of functions for ``ControlFlow`` (Control Flow).

### `controlFlowConversionFunctions`

```swift
public static let controlFlowConversionFunctions: [Function] = [
    Function(
        id: .controlFlowToBoolean,
        name: .init(localized: .init(
            "Control Flow to Boolean",
            comment: "Array (Function for converting the control flow into a boolean)"
        )),
        description: .init(localized: .init(
            "Convert the control flow into a boolean.",
            comment: "Array (Description of \"Control Flow to Boolean\")"
        )),
        input: [.init(.controlFlow, type: ControlFlow.self)],
        output: [.init(.boolean, type: Bool.self)]
    ) { input in
        [(input.first as? ControlFlow ?? .noSignal) == .signal]
    }
]
```

Convert the control flow into other types.

### `mergeFlowGroup`

```swift
public static let mergeFlowGroup: Self =
    [
        .init(
            .init(
                localized: .init(
                    "Merge Flow",
                    comment: "Array (The localized name of the functions for merging the flow)"
                )
            ),
            icon: .init(systemSymbol: .arrowTriangleMerge)
        ) {
            for function in mergeFlowFunctions { function }
        }
    ]
```

The group of the merge flow functions.

### `mergeFlowFunctions`

```swift
@ArrayBuilder<Function> public static var mergeFlowFunctions: [Function]
```

The functions for merging the flow
of ``String`` (Text), ``Double`` (Number), ``Bool`` (Boolean) and ``ControlFlow`` (Control Flow).

### `default`

```swift
public static let `default`
=
numberFunctions + textFunctions + booleanFunctions + controlFlowFunctions + mergeFlowGroup
```

A set of functions for the default types ``String`` (Text), ``Double`` (Number), ``Bool`` (Boolean)
and ``ControlFlow`` (Control Flow).

### `numberFunctions`

```swift
public static let numberFunctions: Self =
    [
        .init(
            .init(
                localized: .init(
                    "Number Operators",
                    comment: "Array (The localized name of the operators set in the number functions)"
                )
            ),
            icon: .init(systemSymbol: .divide)
        ) {
            for function in numberOperatorsFunctions { function }
        },
        .init(
            .init(
                localized: .init(
                    "Number Relations",
                    comment: "Array (The localized name of the relations set in the number functions)"
                )
            ),
            icon: .init(systemSymbol: .greaterthan)
        ) {
            for function in numberRelationsFunctions { function }
        },
        .init(
            .init(
                localized: .init(
                    "Convert Number",
                    comment: "Array (The localized name of the conversion set in the number functions)"
                )
            ),
            icon: .init(systemSymbol: .arrowRight)
        ) {
            for function in numberConversionFunctions { function }
        }
    ]
```

A set of functions for ``Double`` (Number).

### `numberOperatorsFunctions`

```swift
public static let numberOperatorsFunctions: [Function] = [
    Function(
        id: .addNumbers,
        name: .init(localized: .init("Add Numbers", comment: "Array (Function for adding two numbers)")),
        description: .init(localized: .init("Add two numbers.", comment: "Array (Description of \"Add Numbers\")")),
        input: [.init(.number1, type: Double.self), .init(.number2, type: Double.self)],
        output: [
            .init(
                .init(localized: .init("Sum", comment: "Array (Output parameter of number addition function)") ),
                type: Double.self
            )
        ]
    ) { input in
        [(input.first as? Double ?? 0) + (input[safe: 1] as? Double ?? 0)]
    },
    Function(
        id: .subtractNumbers,
        name: .init(localized: .init("Subtract Numbers", comment: "Array (Function for subtracting two numbers)")),
        description: .init(localized: .init(
            "Subtract two numbers.",
            comment: "Array (Description of \"Subtract Numbers\")"
        )),
        input: [.init(.number1, type: Double.self), .init(.number2, type: Double.self)],
        output: [
            .init(
                .init(localized: .init(
                    "Difference",
                    comment: "Array (Output parameter of number subtraction function)"
                )),
                type: Double.self
            )
        ]
    ) { input in
        [(input.first as? Double ?? 0) - (input[safe: 1] as? Double ?? 0)]
    },
    Function(
        id: .multiplyNumbers,
        name: .init(localized: .init("Multiply Numbers", comment: "Array (Function for multiplying two numbers)")),
        description: .init(localized: .init(
            "Multiply two numbers.",
            comment: "Array (Description of \"Multiply Numbers\")"
        )),
        input: [.init(.number1, type: Double.self), .init(.number2, type: Double.self)],
        output: [
            .init(
                .init(localized: .init(
                    "Factor",
                    comment: "Array (Output parameter of number multiplication function)"
                )),
                type: Double.self
            )
        ]
    ) { input in
        [(input.first as? Double ?? 1) * (input[safe: 1] as? Double ?? 1)]
    },
    Function(
        id: .divideNumbers,
        name: .init(localized: .init("Divide Numbers", comment: "Array (Function for dividing two numbers)")),
        description: .init(localized: .init(
            "Divide two numbers.",
            comment: "Array (Description of \"Divide Numbers\")"
        )),
        input: [.init(.number1, type: Double.self), .init(.number2, type: Double.self)],
        output: [
            .init(
                .init(localized: .init(
                    "Quotient",
                    comment: "Array (Output parameter of number division function)"
                )),
                type: Double.self
            )
        ]
    ) { input in
        var number2 = input[safe: 1] as? Double ?? 1
        number2 = number2 == 0 ? 1 : number2
        return [(input.first as? Double ?? 1) / (number2)]
    }
]
```

Operators for numbers as functions.

### `numberRelationsFunctions`

```swift
public static let numberRelationsFunctions: [Function] = [
    Function(
        id: .equalNumbers,
        name: .init(localized: .init("Equal", comment: "Array (Function for checking if two numbers are equal)")),
        description: .init(localized: .init(
            "Check if two numbers are equal.",
            comment: "Array (Description of \"Equal\")"
        )),
        input: [.init(.number1, type: Double.self), .init(.number2, type: Double.self)],
        output: [
            .init(
                .init(localized: .init("Equality", comment: "Array (Output parameter of equal numbers function)") ),
                type: Bool.self
            )
        ]
    ) { input in
        [(input.first as? Double ?? 0) == (input[safe: 1] as? Double ?? 0)]
    },
    Function(
        id: .greaterThan,
        name: .init(localized: .init(
            "Greater Than",
            comment: "Array (Function for checking if a number is greater than another)"
        )),
        description: .init(localized: .init(
            "Check if the first number is greater than the second number.",
            comment: "Array (Description of \"Greater Than\")"
        )),
        input: [.init(.number1, type: Double.self), .init(.number2, type: Double.self)],
        output: [.init(.comparison, type: Bool.self)]
    ) { input in
        [(input.first as? Double ?? 0) > (input[safe: 1] as? Double ?? 0)]
    }
]
```

Check relations of numbers as functions.

### `numberConversionFunctions`

```swift
public static let numberConversionFunctions: [Function] = [
    Function(
        id: .numberToText,
        name: .init(localized: .init(
            "Number to Text",
            comment: "Array (Function for converting a number into a text)"
        )),
        description: .init(localized: .init(
            "Convert a number into a text.",
            comment: "Array (Description of \"Number to Text\")"
        )),
        input: [.init(.number, type: Double.self)],
        output: [.init(.text, type: String.self)]
    ) { input in
        let number = input.first as? Double ?? 0
        let integer = Int(number)
        if number - Double(integer) == 0 {
            return [String(integer)]
        }
        return [String(number)]
    }
]
```

Convert numbers into other types.

### `textFunctions`

```swift
public static let textFunctions: Self =
    [
        .init(
            .init(
                localized: .init(
                    "Text Operators",
                    comment: "Array (The localized name of the operators set in the text functions)"
                )
            ),
            icon: .init(systemSymbol: .plus)
        ) {
            for function in textOperatorsFunctions { function }
        },
        .init(
            .init(
                localized: .init(
                    "Text Relations",
                    comment: "Array (The localized name of the relations set in the text functions)"
                )
            ),
            icon: .init(systemSymbol: .equal)
        ) {
            for function in textRelationsFunctions { function }
        },
        .init(
            .init(
                localized: .init(
                    "Convert Text",
                    comment: "Array (The localized name of the conversion set in the text functions)"
                )
            ),
            icon: .init(systemSymbol: .arrowRight)
        ) {
            for function in textConversionFunctions { function }
        }
    ]
```

A set of functions for ``String`` (Text).

### `textOperatorsFunctions`

```swift
public static let textOperatorsFunctions: [Function] = [
    Function(
        id: .addText,
        name: .init(localized: .init("Add Text", comment: "Array (Function for adding two text snippets)")),
        description: .init(localized: .init(
            "Add two text snippets.",
            comment: "Array (Description of \"Add Text\")"
        )),
        input: [.init(.text1, type: String.self), .init(.text2, type: String.self)],
        output: [
            .init(
                .init(localized: .init("Text", comment: "Array (Output parameter of text addition function)") ),
                type: String.self
            )
        ]
    ) { input in
        [(input.first as? String ?? "") + (input[safe: 1] as? String ?? "")]
    }
]
```

Operators for text as functions.

### `textRelationsFunctions`

```swift
public static let textRelationsFunctions: [Function] = [
    Function(
        id: .equalText,
        name: .init(localized: .init(
            "Equal",
            comment: "Array (Function for checking if two text snippets are equal)"
        )),
        description: .init(localized: .init(
            "Check if two text snippets are equal.",
            comment: "Array (Description of \"Equal\")"
        )),
        input: [.init(.text1, type: String.self), .init(.text2, type: String.self)],
        output: [
            .init(
                .init(localized: .init("Equality", comment: "Array (Output parameter of equal text function)") ),
                type: Bool.self
            )
        ]
    ) { input in
        [(input.first as? String ?? "") == (input[safe: 1] as? String ?? "")]
    }
]
```

Check relations of text as functions.

### `textConversionFunctions`

```swift
public static let textConversionFunctions: [Function] = [
    Function(
        id: .textToNumber,
        name: .init(localized: .init(
            "Text to Number",
            comment: "Array (Function for converting a text into a number)"
        )),
        description: .init(localized: .init(
            "Convert a text into a number.",
            comment: "Array (Description of \"Text to Number\")"
        )),
        input: [.init(.text, type: String.self)],
        output: [.init(.number, type: Double.self)]
    ) { input in
        [Double(input.first as? String ?? "") ?? 0]
    }
]
```

Convert text into other types.

### `booleanFunctions`

```swift
public static let booleanFunctions: Self =
    [
        .init(
            .init(
                localized: .init(
                    "Logical Operators",
                    comment: "Array (The localized name of the logical operators set in the boolean functions)"
                )
            ),
            icon: .init(systemSymbol: .exclamationmark)
        ) {
            for function in logicalOperatorsFunctions { function }
        },
        .init(
            .init(
                localized: .init(
                    "Convert Boolean",
                    comment: "Array (The localized name of the conversion set in the boolean functions)"
                )
            ),
            icon: .init(systemSymbol: .arrowRight)
        ) {
            for function in booleanConversionFunctions { function }
        }
    ]
```

A set of functions for ``Bool`` (Boolean).

### `logicalOperatorsFunctions`

```swift
public static let logicalOperatorsFunctions: [Function] = [
    Function(
        id: .and,
        name: .init(localized: .init(
            "And",
            comment: "Array (Logical \"And\" operator as function)"
        )),
        description: .init(localized: .init(
            "The output is only true if both of the inputs are true.",
            comment: "Array (Description of \"And\")"
        )),
        input: [.init(.boolean1, type: Bool.self), .init(.boolean2, type: Bool.self)],
        output: [.init(.boolean, type: Bool.self)]
    ) { input in
        [(input.first as? Bool ?? false) && (input[safe: 1] as? Bool ?? false)]
    },
    Function(
        id: .orOperator,
        name: .init(localized: .init(
            "Or",
            comment: "Array (Logical \"Or\" operator as function)"
        )),
        description: .init(localized: .init(
            "The output is true if at least one of the inputs is true.",
            comment: "Array (Description of \"Or\")"
        )),
        input: [.init(.boolean1, type: Bool.self), .init(.boolean2, type: Bool.self)],
        output: [.init(.boolean, type: Bool.self)]
    ) { input in
        [(input.first as? Bool ?? false) || (input[safe: 1] as? Bool ?? false)]
    },
    Function(
        id: .not,
        name: .init(localized: .init(
            "Not",
            comment: "Array (Logical \"Not\" operator as function)"
        )),
        description: .init(localized: .init(
            "Reverse the logical state of the input.",
            comment: "Array (Description of \"Not\")"
        )),
        input: [.init(.boolean, type: Bool.self)],
        output: [.init(.boolean, type: Bool.self)]
    ) { input in
        [!(input.first as? Bool ?? true)]
    }
]
```

Logical operators functions.

### `booleanConversionFunctions`

```swift
public static let booleanConversionFunctions: [Function] = [
    Function(
        id: .booleanToControlFlow,
        name: .init(localized: .init(
            "Boolean to Control Flow",
            comment: "Array (Function for converting a boolean into the control flow)"
        )),
        description: .init(localized: .init(
            "Convert a boolean into the control flow.",
            comment: "Array (Description of \"Boolean to Contorl Flow\")"
        )),
        input: [.init(.boolean, type: Bool.self)],
        output: [.init(.controlFlow, type: ControlFlow.self)]
    ) { input in
        [(input.first as? Bool ?? false) ? ControlFlow.signal : ControlFlow.noSignal]
    }
]
```

Convert booleans into other types.
