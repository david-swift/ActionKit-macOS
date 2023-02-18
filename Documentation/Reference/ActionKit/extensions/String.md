**EXTENSION**

# `String`
```swift
extension String: ActionType
```

## Properties
### `name`

```swift
public static var name: String
```

The String's name for the actions.

### `color`

```swift
public static var color: Color
```

The String's color for the actions.

### `input`

```swift
static var input: Self
```

The identifier of the input function.

### `output`

```swift
static var output: Self
```

The identifier of the output function.

### `addNumbers`

```swift
static var addNumbers: Self
```

The identifier of the add numbers function.

### `subtractNumbers`

```swift
static var subtractNumbers: Self
```

The identifier of the subtract numbers function.

### `multiplyNumbers`

```swift
static var multiplyNumbers: Self
```

The identifier of the multiply numbers function.

### `divideNumbers`

```swift
static var divideNumbers: Self
```

The identifier of the divide numbers function.

### `equalNumbers`

```swift
static var equalNumbers: Self
```

The identifier of the equal numbers function.

### `greaterThan`

```swift
static var greaterThan: Self
```

The identifier of the greater than number function.

### `numberToText`

```swift
static var numberToText: Self
```

The identifier of the text conversion number function.

### `number1`

```swift
static var number1: Self
```

The first number in a function taking multiple numbers without a specific function.

### `number2`

```swift
static var number2: Self
```

The second number in a function taking multiple numbers without a specific function.

### `number`

```swift
static var number: Self
```

The number in a function taking a single number without a specific function.

### `addText`

```swift
static var addText: Self
```

The identifier of the add text function.

### `equalText`

```swift
static var equalText: Self
```

The identifier of the equal text function.

### `textToNumber`

```swift
static var textToNumber: Self
```

The identifier of the text to number function.

### `text1`

```swift
static var text1: Self
```

The first text in a function taking multiple text snippets without a specific function.

### `text2`

```swift
static var text2: Self
```

The second text in a function taking multiple text snippets without a specific function.

### `text`

```swift
static var text: Self
```

The text in a function taking a single text snippet without a specific function.

### `and`

```swift
static var and: Self
```

The identifier of the and boolean function.

### `orOperator`

```swift
static var orOperator: Self
```

The identifier of the or boolean function.

### `not`

```swift
static var not: Self
```

The identifier of the not boolean function.

### `booleanToControlFlow`

```swift
static var booleanToControlFlow: Self
```

The identifier of the boolean to control flow function.

### `boolean1`

```swift
static var boolean1: Self
```

The first boolean in a function taking multiple booleans without a specific function.

### `boolean2`

```swift
static var boolean2: Self
```

The second boolean in a function taking multiple booleans without a specific function.

### `boolean`

```swift
static var boolean: Self
```

The boolean in a function taking a single boolean without a specific function.

### `comparison`

```swift
static var comparison: Self
```

The result of a comparison in a function.

### `controlFlowToBoolean`

```swift
static var controlFlowToBoolean: Self
```

The identifier of the control flow to boolean function.

### `controlFlow`

```swift
static var controlFlow: Self
```

The control flow in a function taking a single control flow without a specific function.

### `value1`

```swift
static var value1: Self
```

The first generic type name in a function taking multiple values of that type without a specific function.

### `value2`

```swift
static var value2: Self
```

The second generic type name in a function taking multiple values of that type without a specific function.

### `value`

```swift
static var value: Self
```

The generic type name in a function taking a single value of that type without a specific function.

## Methods
### `picker(value:)`

```swift
public static func picker(value: Binding<ActionType>) -> any View
```

A text field for changing a text value.
- Parameter value: The text.
- Returns: A view containing the text field.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | The text. |