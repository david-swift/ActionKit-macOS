**STRUCT**

# `DragFunctionView`

```swift
struct DragFunctionView: View
```

The view displaying the dragged function.

## Properties
### `dragFunction`

```swift
@Binding var dragFunction: DragFunction?
```

Information about the dragging.

### `function`

```swift
@Binding var function: Function
```

The parent function.

### `scrollValue`

```swift
var scrollValue: CGPoint
```

The position in the scroll view.

### `body`

```swift
var body: some View
```

The view's body.
