**EXTENSION**

# `CGPoint`
```swift
extension CGPoint
```

## Methods
### `map(max:)`

```swift
mutating func map(max maxValue: CGFloat)
```

Map a CGPoint in a certain range for limiting the freedom of movement of a node.
- Parameter maxValue: The maximum value.

#### Parameters

| Name | Description |
| ---- | ----------- |
| maxValue | The maximum value. |

### `add(size:)`

```swift
func add(size: CGSize) -> Self
```

Add a ``CGSize`` to a ``CGPoint``.
- Parameter size: The size to add.
- Returns: The new point with the size added.

#### Parameters

| Name | Description |
| ---- | ----------- |
| size | The size to add. |