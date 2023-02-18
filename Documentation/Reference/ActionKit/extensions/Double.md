**EXTENSION**

# `Double`
```swift
extension Double: ActionType
```

## Properties
### `name`

```swift
public static var name: String
```

The Double's name for the actions.

### `color`

```swift
public static var color: Color
```

The Double's color for the actions.

### `nodeOpacity`

```swift
internal static var nodeOpacity: Self
```

The opacity of a node background.

### `selectedAnimationSpeed`

```swift
internal static var selectedAnimationSpeed: Self
```

The speed of the selection animation of a node.

### `nodeShadowOpacity`

```swift
static var nodeShadowOpacity: Self
```

The opacity of a node's shadow.

### `selectionRectangleOpacity`

```swift
static var selectionRectangleOpacity: Self
```

The opacity of the selection rectangle.

### `backgroundDotOpacity`

```swift
static var backgroundDotOpacity: Self
```

The opacity of a dot in the background of a canvas editor.

### `dragFunctionOpacity`

```swift
static var dragFunctionOpacity: Self
```

The opacity of the name of the dragged function.

### `errorMessageAnimationSpeed`

```swift
static var errorMessageAnimationSpeed: Self
```

The speed of the animation in ``ErrorMessage``.

### `errorMessageIconScaleEffect`

```swift
static var errorMessageIconScaleEffect: Self
```

The maximum scale effect of the icon in ``ErrorMessage``.

### `displayError`

```swift
static var displayError: Self
```

Seconds to display an error message to the user.

### `functionPopoverZoom`

```swift
static var functionPopoverZoom: Self
```

The zoom value of the function definition popover of a node.

### `dragAnimationSpeed`

```swift
static var dragAnimationSpeed: Self
```

The speed of animations that have to do with the dragging gesture.

### `hoverIndicatorOpacity`

```swift
static var hoverIndicatorOpacity: Self
```

The opacity of the hover indicator in a parmater's view.

### `actionButtonStrokeOpacity`

```swift
static var actionButtonStrokeOpacity: Self
```

The opacity of the stroke around an action button.

## Methods
### `picker(value:)`

```swift
public static func picker(value: Binding<ActionType>) -> any View
```

A text field for choosing a ``Double`` value.
- Parameter value: The binded value.
- Returns: A view containing the text field.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | The binded value. |