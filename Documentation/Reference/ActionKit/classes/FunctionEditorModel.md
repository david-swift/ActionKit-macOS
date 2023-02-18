**CLASS**

# `FunctionEditorModel`

```swift
class FunctionEditorModel: ObservableObject
```

Information for the function editor.

## Properties
### `selection`

```swift
@Published var selection: Set<UUID> = []
```

The selected nodes.

### `dragWire`

```swift
@Published var dragWire: DragWire?
```

Information about dragging a wire.

### `dragFunction`

```swift
@Published var dragFunction: DragFunction?
```

Information about dragging a function for adding into the code editor.

### `error`

```swift
@Published var error: FunctionError = .noError
```

Information about the displayed error.

### `actions`

```swift
@Published var actions: ActionVisibility = .menu
```

Whether the actions are visible.

### `zoom`

```swift
@Published var zoom: Double
```

The zoom, default is 1.

### `expandFunctionsView`

```swift
@Published var expandFunctionsView = false
```

Whether the view containing all the available functions is expanded.

### `functionsView`

```swift
@Published var functionsView: Bool
```

Whether the view containing all the available functions is displayed.

### `scrollValue`

```swift
@Published var scrollValue: CGPoint = .zero
```

The point in the scroll view that is at the origin of the window.

## Methods
### `init(zoom:functionsView:)`

```swift
init(zoom: Double, functionsView: Bool)
```

Initialize a function editor model.
- Parameters:
  - zoom: The zoom.
  - functionsView: Whether the functions view is displayed.

#### Parameters

| Name | Description |
| ---- | ----------- |
| zoom | The zoom. |
| functionsView | Whether the functions view is displayed. |