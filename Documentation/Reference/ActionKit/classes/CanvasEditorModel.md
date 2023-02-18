**CLASS**

# `CanvasEditorModel`

```swift
class CanvasEditorModel: ObservableObject
```

Information about an instance of the ``CanvasEditor``.

## Properties
### `selectionRectangle`

```swift
@Published var selectionRectangle: CGRect = .zero
```

The rectangle for selecting nodes.

### `showSelectionRectangle`

```swift
@Published var showSelectionRectangle = false
```

Whether the rectangle for selecting nodes is visible.
