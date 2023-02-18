**STRUCT**

# `FunctionsGroupView`

```swift
struct FunctionsGroupView: View
```

The view of a functions group in the expanded ``FunctionsView``.

## Properties
### `dragFunction`

```swift
@Binding var dragFunction: DragFunction?
```

Information about the dragging of a function.

### `isExpanded`

```swift
@State private var isExpanded = true
```

Whether the group view is expanded.

### `group`

```swift
var group: Folder<Function>
```

The group.

### `body`

```swift
var body: some View
```

The view's body.
