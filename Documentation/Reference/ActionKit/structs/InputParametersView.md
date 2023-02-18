**STRUCT**

# `InputParametersView`

```swift
struct InputParametersView: View
```

A view for defining parameter values manually.

## Properties
### `node`

```swift
@Binding var node: Node
```

The node to edit.

### `actions`

```swift
@Binding var actions: ActionVisibility
```

The visibility of the actions.

### `wires`

```swift
@Binding var wires: [Wire]
```

The parent function's wires.

### `function`

```swift
var function: Function?
```

The node's function.

### `nodeID`

```swift
var nodeID: Int
```

The node's index.

### `body`

```swift
var body: some View
```

The view's body.

### `inputSheetToolbar`

```swift
@ToolbarContentBuilder private var inputSheetToolbar: some ToolbarContent
```

The parameters view's toolbar.

## Methods
### `parameterColumn(value:)`

```swift
private func parameterColumn(value: Parameter) -> some View
```

The column with the parameter's name and type.
- Parameter value: The parameter.
- Returns: A view containing information about the parameter.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | The parameter. |

### `valueColumn(value:)`

```swift
@ViewBuilder private func valueColumn(value: Parameter) -> some View
```

The column with the option to toggle between the manual definition and the definition with wires
and to manually define the value.
- Parameter value: The parameter.
- Returns: A view for editing the value.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | The parameter. |

### `index(parameter:)`

```swift
private func index(parameter: Parameter) -> Int?
```

Get the index of a parameter.
- Parameter parameter: A parameter.
- Returns: The parameter's index.

#### Parameters

| Name | Description |
| ---- | ----------- |
| parameter | A parameter. |

### `setManually(index:)`

```swift
private func setManually(index: Int?) -> Bool
```

Whether the parameter at a certain index is defined manually.
- Parameter index: The parameter's index.
- Returns: Whether the parameter is defined manually.

#### Parameters

| Name | Description |
| ---- | ----------- |
| index | The parameter’s index. |