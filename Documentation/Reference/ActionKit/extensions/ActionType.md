**EXTENSION**

# `ActionType`
```swift
extension ActionType
```

## Properties
### `mergeFlowFunction`

```swift
public static var mergeFlowFunction: Function
```

A function for merging two control or data flows.
It is interpreted as a special function where only one of the inputs has to be a value.

## Methods
### `pickerView(value:)`

```swift
static func pickerView(value: Binding<ActionType>) -> AnyView
```

The picker view as an ``AnyView``.
- Parameter value: The picked value.
- Returns: The picker view as an ``AnyView``.

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | The picked value. |