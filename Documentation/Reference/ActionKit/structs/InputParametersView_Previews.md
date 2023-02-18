**STRUCT**

# `InputParametersView_Previews`

```swift
struct InputParametersView_Previews: PreviewProvider, View
```

Previews for the ``InputParametersView``.

## Properties
### `previews`

```swift
static var previews: some View
```

The previews.

### `node`

```swift
@State private var node = Node(function: "hi")
```

The node for testing the input parameters view.

### `actions`

```swift
@State private var actions: ActionVisibility = .menu
```

The action visibility for testing the input parameters view.

### `body`

```swift
var body: some View
```

The view's body.
