**EXTENSION**

# `Binding`
```swift
extension Binding where Value == ActionType
```

## Methods
### `get(default:)`

```swift
internal func get<T>(default defaultValue: T) -> Binding<T> where T: ActionType
```

Get the binding with the ``ActionType`` value
as a binding with a value conforming to the ``ActionType`` protocol.
- Parameter defaultValue: This value is taken if the conversion fails.
- Returns: The new binding.

#### Parameters

| Name | Description |
| ---- | ----------- |
| defaultValue | This value is taken if the conversion fails. |