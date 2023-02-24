**STRUCT**

# `FunctionEditor`

```swift
public struct FunctionEditor: View
```

The editor for a function.

## Properties
### `function`

```swift
@Binding public var function: Function
```

The function that can be edited in this editor.

### `model`

```swift
@StateObject var model: FunctionEditorModel
```

The instance of the function editor model.

### `openNode`

```swift
var openNode: ((Function) -> Void)?
```

The function that is called when a node should be opened.
If this function is ``nil``, there won't be a button for opening a node's definition.

### `extraActions`

```swift
var extraActions: [ExtraAction]
```

Additions to the actions displayed in the bottom right corner of the editor.
Ideal for for example displaying a "Run" button.

### `observeSelection`

```swift
var observeSelection: Binding<Set<UUID>>?
```

The selected nodes.

### `observeActions`

```swift
var observeActions: Binding<ActionVisibility>?
```

The actions visibility.

### `observeExpandFunctions`

```swift
var observeExpandFunctions: Binding<Bool>?
```

The expansion of the functions view.

### `developerError`

```swift
var developerError: Binding<String?>?
```

An error thrown by the developer.

### `body`

```swift
public var body: some View
```

The ``FunctionEditor``'s view.

### `wires`

```swift
var wires: some View
```

The layer containing the wires.

### `errors`

```swift
var errors: some View
```

The view layer for showing the errors.

## Methods
### `init(_:zoom:functionsView:openNode:extraActions:)`

```swift
public init(
    _ function: Binding<Function>,
    zoom: Double = 1,
    functionsView: Bool = true,
    openNode: ((Function) -> Void)? = nil,
    @ArrayBuilder<ExtraAction> extraActions: () -> [ExtraAction] = { [] }
)
```

The initializer for the function editor.
- Parameters:
  - function: The editable function as a binding.
  - zoom: The zoom value.
  - functionsView: Whether there is a view showing all the functions or not.
  - openNode: The function for opening the definition of a node's function.
  - extraActions: Buttons displayed directly above the functions view in the editor.

#### Parameters

| Name | Description |
| ---- | ----------- |
| function | The editable function as a binding. |
| zoom | The zoom value. |
| functionsView | Whether there is a view showing all the functions or not. |
| openNode | The function for opening the definition of a node’s function. |
| extraActions | Buttons displayed directly above the functions view in the editor. |