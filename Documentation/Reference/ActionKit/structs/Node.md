**STRUCT**

# `Node`

```swift
public struct Node: Identifiable, Equatable
```

The representation of a function in the ``FunctionEditor``.

## Properties
### `id`

```swift
public let id: UUID
```

The node's identifier.

### `position`

```swift
var position: CGPoint
```

The node's position in the editor coordinate space.

### `function`

```swift
var function: String
```

The identifier of the function of the node.

### `values`

```swift
var values: [Int: ActionType]
```

Values for the input parameters.

### `isSignal`

```swift
private var isSignal: Bool
```

Whether the node is in its default configuration.

## Methods
### `init(function:id:position:values:)`

```swift
public init(
    function: String,
    id: UUID = .init(),
    position: CGPoint = .init(x: .randomPosition, y: .randomPosition),
    values: [Int: ActionType] = [0: ControlFlow.signal]
)
```

A node's initializer.
- Parameters:
  - function: The identifier of the function of the node.
  - id: The node's identifier.
  - position: The node's position in the editor coordinate space.
  - values: The input parameters that are defined manually.

#### Parameters

| Name | Description |
| ---- | ----------- |
| function | The identifier of the function of the node. |
| id | The node’s identifier. |
| position | The node’s position in the editor coordinate space. |
| values | The input parameters that are defined manually. |

### `==(_:_:)`

```swift
public static func == (lhs: Self, rhs: Self) -> Bool
```

Checks whether two nodes are the same.
- Parameters:
  - lhs: The first node.
  - rhs: The second node.
- Returns: Whether the two nodes are the same.

#### Parameters

| Name | Description |
| ---- | ----------- |
| lhs | The first node. |
| rhs | The second node. |