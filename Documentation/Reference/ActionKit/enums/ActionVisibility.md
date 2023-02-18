**ENUM**

# `ActionVisibility`

```swift
public enum ActionVisibility
```

The visibility of the actions to edit a node.

## Cases
### `hidden`

```swift
case hidden
```

The actions menu is hidden.

### `menu`

```swift
case menu
```

The actions menu is visible.

### `parameters`

```swift
case parameters
```

The actions menu and the parameters popover are visible.

### `definition`

```swift
case definition
```

The actions menu and the definition popover are visible.

## Methods
### `toggle()`

```swift
mutating func toggle()
```

Toggle the visibility betweem ``hidden`` and ``menu``.
