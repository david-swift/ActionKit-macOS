**ENUM**

# `ControlFlow`

```swift
public enum ControlFlow: ActionType, CaseIterable, Identifiable
```

A type used as a parameter for representing the control flow.

## Cases
### `signal`

```swift
case signal
```

There is a signal at the node.

### `noSignal`

```swift
case noSignal
```

There is no signal at the node.

## Properties
### `name`

```swift
public static var name: String
```

The name of the control flow type.

### `color`

```swift
public static var color: Color
```

The color of the control flow type.

### `id`

```swift
public var id: Int
```

The identifier.

### `localized`

```swift
var localized: LocalizedStringResource
```

The localized name of each case of ``ControlFlow``.

## Methods
### `init()`

```swift
public init()
```

The standard value.

### `picker(value:)`

```swift
public static func picker(value: Binding<ActionType>) -> any View
```

A picker for choosing a control flow value.
- Parameter value: The value.
- Returns: The view containing the picker.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | The value. |