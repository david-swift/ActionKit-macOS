**EXTENSION**

# `FunctionEditor`
```swift
extension FunctionEditor
```

## Methods
### `inputPosition(nodePosition:function:index:)`

```swift
static func inputPosition(nodePosition: CGPoint?, function: Function?, index: Int) -> CGPoint
```

Get the position of an input point.
- Parameters:
  - nodePosition: The node's position.
  - function: The node's function.
  - index: The point's index.
- Returns: The input point's position.

#### Parameters

| Name | Description |
| ---- | ----------- |
| nodePosition | The node’s position. |
| function | The node’s function. |
| index | The point’s index. |

### `outputPosition(nodePosition:function:index:)`

```swift
static func outputPosition(nodePosition: CGPoint?, function: Function?, index: Int) -> CGPoint
```

Get the position of an output point.
- Parameters:
  - nodePosition: The node's position.
  - function: The node's function.
  - index: The point's index.
- Returns: The output point's position.

#### Parameters

| Name | Description |
| ---- | ----------- |
| nodePosition | The node’s position. |
| function | The node’s function. |
| index | The point’s index. |

### `dragGesture(node:)`

```swift
private func dragGesture(node: Node) -> some Gesture
```

The drag gesture of a node.
- Parameter node: The node.
- Returns: The gesture.

#### Parameters

| Name | Description |
| ---- | ----------- |
| node | The node. |

### `nodesView(selectionRectangle:)`

```swift
func nodesView(selectionRectangle: CGRect?) -> some View
```

The view layer for showing the nodes.
- Parameter selectionRectangle: The seleciton rectangle.
- Returns: The view layer for showing the nodes.

#### Parameters

| Name | Description |
| ---- | ----------- |
| selectionRectangle | The seleciton rectangle. |

### `nodeView(node:)`

```swift
private func nodeView(node: Node) -> some View
```

The view for a single node.
- Parameter node: The node.
- Returns: A view containing the node.

#### Parameters

| Name | Description |
| ---- | ----------- |
| node | The node. |

### `tapGesture(id:modifiers:)`

```swift
private func tapGesture(id: UUID, modifiers: EventModifiers) -> some Gesture
```

A tap gesture for adding an identifier to the selection.
- Parameters:
  - id: The identifier.
  - modifiers: The modifiers that are required.
- Returns: The tap gesture with the modifiers.

#### Parameters

| Name | Description |
| ---- | ----------- |
| id | The identifier. |
| modifiers | The modifiers that are required. |

### `tapGesture(id:)`

```swift
private func tapGesture(id: UUID) -> some Gesture
```

A tap gesture for changing the selection to one node or, if already selected, toggling the actions' visibility.
- Parameter id: The identifier.
- Returns: The tap gesture.

#### Parameters

| Name | Description |
| ---- | ----------- |
| id | The identifier. |

### `changeSelection(id:)`

```swift
private func changeSelection(id: UUID)
```

Add an identifier to or remove an identifier from the node selection.
- Parameter id: The identifier.

#### Parameters

| Name | Description |
| ---- | ----------- |
| id | The identifier. |

### `nodesIndex(id:)`

```swift
private func nodesIndex(id: UUID) -> Int?
```

Get the index of the node with the specified identifier.
- Parameter id: The identifier.
- Returns: The node's index.

#### Parameters

| Name | Description |
| ---- | ----------- |
| id | The identifier. |

### `setPosition(point:node:)`

```swift
private func setPosition(point: CGPoint, node: Node)
```

Set the position of the selected nodes if one of the selected nodes is dragged.
Set the position of the dragged node if it is not part of the selection.
- Parameters:
  - point: The new location.
  - node: The dragged node.

#### Parameters

| Name | Description |
| ---- | ----------- |
| point | The new location. |
| node | The dragged node. |

### `wireView(_:)`

```swift
@ViewBuilder func wireView(_ wire: Wire) -> some View
```

The view layer for a single wire.
- Parameter wire: The wire that should be dislayed.
- Returns: A view containing the wire.

#### Parameters

| Name | Description |
| ---- | ----------- |
| wire | The wire that should be dislayed. |

### `observeSelection(value:)`

```swift
public func observeSelection(value: Binding<Set<UUID>>) -> Self
```

Get the selected nodes.
- Parameter value: The value that is changed with the nodes' selection.
- Returns: The new function editor with the observation of the selection.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | The value that is changed with the nodes’ selection. |

### `observeActions(value:)`

```swift
public func observeActions(value: Binding<ActionVisibility>) -> Self
```

Get the action's state.
- Parameter value: The value that is changed with the action's state.
- Returns: The new function editor with the observation of the actions' visibility.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | The value that is changed with the action’s state. |

### `observeExpandFunctions(value:)`

```swift
public func observeExpandFunctions(value: Binding<Bool>) -> Self
```

Get the expand function's state.
- Parameter value: The value that is changed with the expand function's state.
- Returns: The new function editor with the observation of the expansion.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | The value that is changed with the expand function’s state. |

### `throwError(error:)`

```swift
public func throwError(error: Binding<String?>) -> Self
```

Throw an error as the developer by attaching a binding.
- Parameters:
  - error: The error.
- Returns: The new function.

#### Parameters

| Name | Description |
| ---- | ----------- |
| error | The error. |