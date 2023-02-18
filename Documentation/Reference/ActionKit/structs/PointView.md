**STRUCT**

# `PointView`

```swift
struct PointView: View
```

The view of a single parameter of a node.

## Properties
### `hover`

```swift
@State private var hover = false
```

Whether the parameter is hovered.

### `type`

```swift
var type: ActionType.Type
```

The parameter's type.

### `manuallyDefined`

```swift
var manuallyDefined: Bool
```

Whether the parameter is defined manually.

### `drag`

```swift
var drag: (DragGesture.Value) -> Void
```

This function is called when the drag gesture changes.

### `endDrag`

```swift
var endDrag: (DragGesture.Value) -> Void
```

This function is called when the drag gesture ends.

### `scale`

```swift
var scale: Bool
```

Whether the size of the parameter's point is smaller than the standard.

### `body`

```swift
var body: some View
```

The view's body.
