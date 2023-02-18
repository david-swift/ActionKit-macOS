**EXTENSION**

# `CGFloat`
```swift
extension CGFloat
```

## Properties
### `editorSideLength`

```swift
static var editorSideLength: Self
```

The side length of the function editor.

### `editorPadding`

```swift
static var editorPadding: Self
```

The padding around a canvas editor.

### `halfEditorSideLength`

```swift
static var halfEditorSideLength: Self
```

Half of the editor's side length.

### `standardNodePositionXOffset`

```swift
static var standardNodePositionXOffset: Self
```

The x offset of the standard node position.

### `standardNodePositionYOffset`

```swift
static var standardNodePositionYOffset: Self
```

The y offset of the standard node position.

### `nodePaddingValue`

```swift
static var nodePaddingValue: Self
```

The padding value of a node used for limiting the freedom of movement of a node.

### `curveMultiplier`

```swift
static var curveMultiplier: Self
```

A value for calculating the curve of a node.

### `wireWidth`

```swift
static var wireWidth: Self
```

The width of a wire.

### `randomPosition`

```swift
public static var randomPosition: Self
```

A random position for a default node.

### `pointsPadding`

```swift
static var pointsPadding: Self
```

### `nodeCornerRadius`

```swift
static var nodeCornerRadius: Self
```

The corner radius of nodes and action buttons.

### `shadowRadius`

```swift
static var shadowRadius: Self
```

The radius of shadows in the whole project.

### `nodeLineWidth`

```swift
static var nodeLineWidth: Self
```

The line width of the line around a node.

### `normalWidth`

```swift
static var normalWidth: Self
```

The width of the parameter's section in a node.

### `paddingBetweenPoints`

```swift
static var paddingBetweenPoints: Self
```

The padding between parameter points.

### `selectionRectangleCornerRadius`

```swift
static var selectionRectangleCornerRadius: Self
```

The corner radius of the selection rectangle.

### `errorMessageIconFontSize`

```swift
static var errorMessageIconFontSize: Self
```

The font size of the smallest value of the icon in ``ErrorMessage``.

### `errorMessageCornerRadius`

```swift
static var errorMessageCornerRadius: Self
```

The corner radius of ``ErrorMessage``.

### `functionGroupLabelPadding`

```swift
static var functionGroupLabelPadding: Self
```

The padding of the header of a function group in the expanded functions view.

### `expandedFunctionsViewHeight`

```swift
static var expandedFunctionsViewHeight: Self
```

The window's height is multiplied with this factor to get the expanded functions view's height.

### `compactViewInnerPadding`

```swift
static var compactViewInnerPadding: Self
```

The padding between a function's name and the background.

### `compactViewPadding`

```swift
static var compactViewPadding: Self
```

The padding between the compact functions view and the scroll view.

### `compactViewHeight`

```swift
static var compactViewHeight: Self
```

The compact functions view's height.

### `inputParametersViewMinWidth`

```swift
static var inputParametersViewMinWidth: Self
```

The minimum width of the ``InputParametersView``.

### `inputParametersViewIdealWidth`

```swift
static var inputParametersViewIdealWidth: Self
```

The ideal width of the ``InputParametersView``.

### `inputParametersViewMinHeight`

```swift
static var inputParametersViewMinHeight: Self
```

The minimum height of the ``InputParametersView``.

### `inputParametersViewIdealHeight`

```swift
static var inputParametersViewIdealHeight: Self
```

The ideal height of the ``InputParametersView``.

### `functionPopoverSideLength`

```swift
static var functionPopoverSideLength: Self
```

The side length of the function popover for a node's definition.

### `dragWireOffset`

```swift
static var dragWireOffset: Self
```

The offset of a wire that is dragged.

### `endDragWireOffsetTolerance`

```swift
static var endDragWireOffsetTolerance: Self
```

The tolerance of the distance to a node's center to make it still connect.

### `parameterSmallSideLength`

```swift
static var parameterSmallSideLength: Self
```

The side length if a parameter is not hovered and defined manually.

### `parameterLargeSideLength`

```swift
static var parameterLargeSideLength: Self
```

The standard side length of a parameter.

### `hoverIndicatorSideLength`

```swift
static var hoverIndicatorSideLength: Self
```

The side length of the hover indicator of a parameter.

### `actionButtonPadding`

```swift
static var actionButtonPadding: Self
```

The padding inside an action button's rectangle.

### `horizontalActionButtonPadding`

```swift
static var horizontalActionButtonPadding: Self
```

The horizontal padding inside an action button's rectangle added to the ``actionButtonPadding``.

### `functionsViewDividerPadding`

```swift
static var functionsViewDividerPadding: Self
```

The padding of a divider in the compact functions view.

## Methods
### `half(_:)`

```swift
static func half(_ number: Self) -> Self
```

Get half of the provided number.
- Parameter number: The number.
- Returns: Half of the number.

#### Parameters

| Name | Description |
| ---- | ----------- |
| number | The number. |

### `nodeToolbarPosition(_:)`

```swift
static func nodeToolbarPosition(_ height: Self) -> Self
```

The freeform toolbar's position of a node.
- Parameter height: The node's height.
- Returns: The freeform toolbar's position relative to the node.

#### Parameters

| Name | Description |
| ---- | ----------- |
| height | The node’s height. |