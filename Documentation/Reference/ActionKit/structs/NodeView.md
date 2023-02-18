**STRUCT**

# `NodeView`

```swift
struct NodeView: View
```

The view for a node.

## Properties
### `node`

```swift
@Binding var node: Node
```

The node's function.

### `function`

```swift
@Binding var function: Function
```

The parent function.

### `dragGesture`

```swift
@Binding var dragGesture: DragWire?
```

The drag gesture for a wire.

### `actions`

```swift
@Binding var actions: ActionVisibility
```

The presentation of the actions.

### `error`

```swift
@Binding var error: FunctionError
```

The presentation of the error.

### `selected`

```swift
@Binding var selected: Bool
```

Whether the node is selected.

### `id`

```swift
var id: Int
```

The node's index.

### `open`

```swift
var open: ((Function) -> Void)?
```

The function for opening a function's definition.

### `body`

```swift
var body: some View
```

The view's body.

### `nodeFunction`

```swift
private var nodeFunction: Function?
```

The node's function.

### `tools`

```swift
@ArrayBuilder<Action> private var tools: [Action]
```

The actions for the node.
They are defined with ``NodeView.Action`` so that they can be used in the custom actions view
and in the context menu.

### `inputPoints`

```swift
private var inputPoints: some View
```

The input points view.

### `outputPoints`

```swift
private var outputPoints: some View
```

The output points view.

### `background`

```swift
private var background: some View
```

The node's background.

### `title`

```swift
private var title: some View
```

The node's title view.

### `height`

```swift
private var height: CGFloat
```

The height of the node view.

### `functionPopover`

```swift
@ViewBuilder private var functionPopover: some View
```

The popover for presenting the definition of the node's function.

## Methods
### `pointPosition(index:)`

```swift
static func pointPosition(index: Int) -> CGFloat
```

Get the position of the parameter point at a certain index.
- Parameter index: The point's index.
- Returns: The position.

#### Parameters

| Name | Description |
| ---- | ----------- |
| index | The point’s index. |

### `height(maxCount:)`

```swift
static func height(maxCount: Int) -> CGFloat
```

Get the height of a node with a specified maximum number of inputs or outputs.
- Parameter maxCount: The number of inputs if there are more inputs than outputs,
or the number of outputs otherwise.
- Returns: The node's height.

#### Parameters

| Name | Description |
| ---- | ----------- |
| maxCount | The number of inputs if there are more inputs than outputs, or the number of outputs otherwise. |

### `pointPosition(_:parameters:)`

```swift
private func pointPosition(_ id: UUID, parameters: [Parameter]) -> CGFloat
```

Get the position of the parameter point with a certain identifier.
- Parameters:
  - id: The identifier.
  - parameters: The parameters.
- Returns: The position.

#### Parameters

| Name | Description |
| ---- | ----------- |
| id | The identifier. |
| parameters | The parameters. |

### `parameterPoints(_:x:output:)`

```swift
private func parameterPoints(_ parameters: [Parameter], x xPos: CGFloat, output: Bool) -> some View
```

Draw a column of parameter points at a certain x position.
- Parameters:
  - parameters: The parameters in the column.
  - xPos: The x value of the position of the column.
  - output: Whether it is an output column for managing the dragging.
- Returns: A view containing the column.

#### Parameters

| Name | Description |
| ---- | ----------- |
| parameters | The parameters in the column. |
| xPos | The x value of the position of the column. |
| output | Whether it is an output column for managing the dragging. |

### `changeDragGesture(value:pos:index:)`

```swift
private func changeDragGesture(value: DragGesture.Value, pos: CGPoint, index: Int)
```

Update the state after a change of the drag gesture.
- Parameters:
  - value: Information about the gesture.
  - pos: The point's position.
  - index: The point's index.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | Information about the gesture. |
| pos | The point’s position. |
| index | The point’s index. |

### `endDragGesture(value:pos:parameter:)`

```swift
private func endDragGesture(value: DragGesture.Value, pos: CGPoint, parameter: Parameter)
```

Update the state when the drag gesture ends.
- Parameters:
  - value: Information about the gesture.
  - pos: The point's position.
  - parameter: The point's parameter.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | Information about the gesture. |
| pos | The point’s position. |
| parameter | The point’s parameter. |