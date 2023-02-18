**EXTENSION**

# `View`
```swift
extension View
```

## Methods
### `actionButton()`

```swift
func actionButton() -> some View
```

The style of an action button on top of the function editor.
- Returns: The view styles as an action button.

### `functionView(dragFunction:function:)`

```swift
func functionView(dragFunction: Binding<DragFunction?>, function: Function) -> some View
```

A draggable function representation in front of the editor.
- Parameters:
  - dragFunction: Information about dragging a function.
  - function: The function.
- Returns: The view with the draggable function view on top.

#### Parameters

| Name | Description |
| ---- | ----------- |
| dragFunction | Information about dragging a function. |
| function | The function. |