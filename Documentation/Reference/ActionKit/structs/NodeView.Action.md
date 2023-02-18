**STRUCT**

# `NodeView.Action`

```swift
private struct Action
```

An action that can be executed on the node.
It is used to provide the same actions to the custom actions view and the context menu.

## Properties
### `title`

```swift
var title: LocalizedStringResource
```

The action's title.

### `icon`

```swift
var icon: Image
```

The action's image.

### `action`

```swift
var action: () -> Void
```

The action.
