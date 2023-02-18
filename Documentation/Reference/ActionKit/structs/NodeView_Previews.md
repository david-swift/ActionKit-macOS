**STRUCT**

# `NodeView_Previews`

```swift
struct NodeView_Previews: PreviewProvider, View
```

The previews for the ``NodeView``.

## Properties
### `previews`

```swift
static var previews: some View
```

The previews.

### `node`

```swift
@State private var node: Node = .init(function: "test")
```

The node for previewing the node view.

### `functions`

```swift
@State private var functions: [Function] = [
    .init(id: "test", name: "Tests", description: "Test", input: [.init("Hello", type: String.self)])
]
```

The functions for previewing the node view.

### `actions`

```swift
@State private var actions: ActionVisibility = .hidden
```

The action visibitliy for previewing the node view.

### `body`

```swift
var body: some View
```

The preview view's body.
