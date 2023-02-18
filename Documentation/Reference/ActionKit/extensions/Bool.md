**EXTENSION**

# `Bool`
```swift
extension Bool: ActionType
```

## Properties
### `name`

```swift
public static var name: String
```

The name of the boolean type.

### `color`

```swift
public static var color: Color
```

The boolean's color.

### `localized`

```swift
internal var localized: LocalizedStringResource
```

The localized names for the Boolean values.

## Methods
### `picker(value:)`

```swift
public static func picker(value: Binding<ActionType>) -> any View
```

A function for getting the picker for a boolean.
- Parameter value: The selected boolean.
- Returns: The picker view.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | The selected boolean. |