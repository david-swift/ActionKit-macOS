**STRUCT**

# `FunctionsView`

```swift
struct FunctionsView: View
```

The view at the bottom of a ``FunctionEditor`` for showing the available functions.

## Properties
### `expand`

```swift
@Binding var expand: Bool
```

Whether the functions view is expanded.

### `dragFunction`

```swift
@Binding var dragFunction: DragFunction?
```

Information about dragging a function into the editor.

### `height`

```swift
@State private var height: CGFloat = 100
```

The expanded functions editor's width.

### `functions`

```swift
var functions: [Folder<Function>]
```

The functions displayed in the functions view.

### `extraActions`

```swift
var extraActions: [FunctionEditor.ExtraAction]
```

Actions added by the developer.

### `body`

```swift
var body: some View
```

The view's body.

### `expandButton`

```swift
private var expandButton: some View
```

A button for expanding the functions view.

### `functionsView`

```swift
private var functionsView: some View
```

The view showing the functions.

### `expandedView`

```swift
private var expandedView: some View
```

The expanded functions view with descriptions.

### `compactView`

```swift
private var compactView: some View
```

The compact functions view without the descriptions.
