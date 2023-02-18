**STRUCT**

# `CanvasEditor`

```swift
public struct CanvasEditor<Item>: View where Item: View
```

A two dimensional scroll view with a dotted background, a selection rectangle and items defined by the developer.

## Properties
### `model`

```swift
@StateObject private var model = CanvasEditorModel()
```

Information about the canvas editor.

### `selection`

```swift
@Binding var selection: Set<UUID>
```

The selected items.

### `items`

```swift
var items: (CGRect?) -> Item
```

The items with the selection rectangle as a parameter.

### `sideLength`

```swift
var sideLength: CGFloat
```

The editor's side length.

### `zoom`

```swift
var zoom: Double
```

The zoom value.

### `scrollFactor`

```swift
var scrollFactor: Binding<CGPoint>?
```

Observes the scroll position.

### `coordinateSpace`

```swift
let coordinateSpace = UUID()
```

The identifier of the coordinate space for observing the scroll position.

### `body`

```swift
public var body: some View
```

The view's body.

### `selectionRectangle`

```swift
@ViewBuilder private var selectionRectangle: some View
```

The view of the rectangle for selecting items.

### `background`

```swift
private var background: some View
```

The dots in the editor's background.

### `selectionRectangleGesture`

```swift
private var selectionRectangleGesture: some Gesture
```

The gesture for showing the selection rectangle.

## Methods
### `init(selection:sideLength:zoom:items:)`

```swift
public init(
    selection: Binding<Set<UUID>>,
    sideLength: CGFloat,
    zoom: Double = 1,
    @ViewBuilder items: @escaping (CGRect?) -> Item
)
```

Initialize a two dimensional scroll view
with a dotted background, a selection rectangle and items defined by the developer.
- Parameters:
  - selection: The selected items. Is cleared when the user clicks the background.
  - sideLength: The editor's side length.
  - zoom: The zoom value. Default is 1.
  - items: The items displayed in the editor.

#### Parameters

| Name | Description |
| ---- | ----------- |
| selection | The selected items. Is cleared when the user clicks the background. |
| sideLength | The editor’s side length. |
| zoom | The zoom value. Default is 1. |
| items | The items displayed in the editor. |

### `drawBackground(context:)`

```swift
private func drawBackground(context: GraphicsContext)
```

Draw the background in a provided graphics context.
- Parameter context: The graphics context that should contain the background.

#### Parameters

| Name | Description |
| ---- | ----------- |
| context | The graphics context that should contain the background. |

### `observeScroll(value:)`

```swift
public func observeScroll(value: Binding<CGPoint>) -> Self
```

Observe the scroll factor of the canvas editor.
- Parameter value: The scroll factor.
- Returns: A new canvas editor with the scroll factor observed.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | The scroll factor. |