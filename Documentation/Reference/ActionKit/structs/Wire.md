**STRUCT**

# `Wire`

```swift
public struct Wire: Identifiable, Equatable
```

A connection between nodes in the ``FunctionEditor``.

## Properties
### `id`

```swift
public let id: UUID
```

The identifier.

### `start`

```swift
var start: (Int, Int)
```

The start parameter.

### `end`

```swift
var end: (Int, Int)
```

The end parameter.

## Methods
### `init(from:to:)`

```swift
public init(from start: (Int, Int), to end: (Int, Int))
```

Initialize a new wire.
- Parameters:
  - start: The start parameter.
  - end: The end parameter.

#### Parameters

| Name | Description |
| ---- | ----------- |
| start | The start parameter. |
| end | The end parameter. |

### `==(_:_:)`

```swift
public static func == (lhs: Self, rhs: Self) -> Bool
```

Checks whether two wires are equal.
- Parameters:
  - lhs: The first wire.
  - rhs: The second wire.
- Returns: Whether the two wires are equal.

#### Parameters

| Name | Description |
| ---- | ----------- |
| lhs | The first wire. |
| rhs | The second wire. |