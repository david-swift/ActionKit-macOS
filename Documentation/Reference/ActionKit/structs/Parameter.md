**STRUCT**

# `Parameter`

```swift
public struct Parameter: Identifiable
```

A parameter of a function.

## Properties
### `id`

```swift
public let id: UUID
```

The identifier.

### `name`

```swift
var name: String
```

The parameter's name that the user can see.

### `type`

```swift
var type: ActionType.Type
```

The parameter's type.

## Methods
### `init(_:type:id:)`

```swift
public init(_ name: String, type: ActionType.Type, id: UUID = .init())
```

A parameter's initializer.
- Parameters:
  - name: The parameter's name.
  - type: The parameter's type.
  - id: The parameter's identifier.

#### Parameters

| Name | Description |
| ---- | ----------- |
| name | The parameter’s name. |
| type | The parameter’s type. |
| id | The parameter’s identifier. |