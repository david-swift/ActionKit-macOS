**STRUCT**

# `FunctionView`

```swift
struct FunctionView: ViewModifier
```

A modifier for a draggable function representation in front of the editor.

## Properties
### `dragFunction`

```swift
@Binding var dragFunction: DragFunction?
```

Information about dragging a function.

### `position`

```swift
@State private var position: CGSize = .zero
```

The function view's position in the global frame.

### `function`

```swift
var function: Function
```

The function.

## Methods
### `body(content:)`

```swift
func body(content: Content) -> some View
```

The modifier's body.
- Parameter content: The content.
- Returns: The view with the gesture.

#### Parameters

| Name | Description |
| ---- | ----------- |
| content | The content. |