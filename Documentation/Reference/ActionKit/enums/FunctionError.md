**ENUM**

# `FunctionError`

```swift
enum FunctionError: Equatable
```

An error that is relevant for the user to see while editing.

## Cases
### `noError`

```swift
case noError
```

There is no error.

### `typeError(type1:type2:)`

```swift
case typeError(type1: ActionType.Type, type2: ActionType.Type)
```

There is a type error. Provide the output and input types.

### `devError(message:)`

```swift
case devError(message: String)
```

There is an error defined by the developer.

## Methods
### `show(error:newError:)`

```swift
static func show(error: Binding<Self>, newError: Self)
```

Show an error and hide it again after five seconds.
- Parameters:
  - error: The error to edit.
  - newError: The error to show.

#### Parameters

| Name | Description |
| ---- | ----------- |
| error | The error to edit. |
| newError | The error to show. |

### `==(_:_:)`

```swift
static func == (lhs: Self, rhs: Self) -> Bool
```

Whether two function errors are the same.
- Parameters:
  - lhs: The first function error.
  - rhs: The second function error.
- Returns: Whether the two function errors are the same.

#### Parameters

| Name | Description |
| ---- | ----------- |
| lhs | The first function error. |
| rhs | The second function error. |