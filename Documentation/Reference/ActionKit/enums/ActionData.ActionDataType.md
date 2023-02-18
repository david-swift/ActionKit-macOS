**ENUM**

# `ActionData.ActionDataType`

```swift
enum ActionDataType
```

The position of the action data
and if the data has been defined manually for an input or it is an output value.

## Cases
### `output(node:point:)`

```swift
case output(node: Int, point: Int)
```

The data is an output value.

### `input(node:point:)`

```swift
case input(node: Int, point: Int)
```

The data has been defined manually for an input.
