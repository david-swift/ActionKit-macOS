**PROTOCOL**

# `ActionType`

```swift
public protocol ActionType: Codable
```

A type that can be used in the actions.

## Properties
### `name`

```swift
static var name: String
```

The description of the action type that the user can see.

### `color`

```swift
static var color: Color
```

The color of the connections of that type.

## Methods
### `init()`

```swift
init()
```

A standard value.

### `picker(value:)`

```swift
@ViewBuilder static func picker(value: Binding<ActionType>) -> any View
```

The view for picking a value. It is used in the parameters view of a node.
This view should look well even in a small frame.
- Parameter value: The picked value.
- Returns: The picker view.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | The picked value. |