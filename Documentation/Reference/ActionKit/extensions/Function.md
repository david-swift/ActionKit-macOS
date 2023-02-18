**EXTENSION**

# `Function`
```swift
extension Function
```

## Methods
### `function(input:startedStep:)`

```swift
func function(input: [ActionType], startedStep: (Int) -> Void = { _ in }) throws -> [ActionType]
```

Execute the function.
- Parameters:
  - input: The function's input node's output values.
  - startedStep: A function that is called before the execution of every node.
- Returns: The function's output node's input values.

#### Parameters

| Name | Description |
| ---- | ----------- |
| input | The function’s input node’s output values. |
| startedStep | A function that is called before the execution of every node. |

### `getCustomOutput(input:startedStep:)`

```swift
func getCustomOutput(input: [ActionType], startedStep: (Int) -> Void) throws -> [ActionType]
```

Execute a custom function.
Check the function first with ``check()``.
- Parameters:
  - input: The function's input node's output values.
  - startedStep: A function that is called before every execution of a node.
- Returns: The function's output node's input values.

#### Parameters

| Name | Description |
| ---- | ----------- |
| input | The function’s input node’s output values. |
| startedStep | A function that is called before every execution of a node. |

### `checkNode(node:data:run:)`

```swift
private func checkNode(node: Node, data: [ActionData], run: (Int, [ActionData]) throws -> Void) throws
```

Execute a certain node if it can be executed.
- Parameters:
  - node: The node to check.
  - data: Data collected from other nodes.
  - run: Run when the node can be executed with the node's index and data as parameters.

#### Parameters

| Name | Description |
| ---- | ----------- |
| node | The node to check. |
| data | Data collected from other nodes. |
| run | Run when the node can be executed with the node’s index and data as parameters. |

### `run(input:startedStep:)`

```swift
public func run(input: [ActionType], startedStep: (Int) -> Void = { _ in }) throws -> [ActionType]
```

Execute the function as the developer.
- Parameters:
  - input: The input values. You should not add the default control flow signal.
  - startedStep: A function that is executed before the execution of every node.
- Returns: The function's output without the default control flow signal.

#### Parameters

| Name | Description |
| ---- | ----------- |
| input | The input values. You should not add the default control flow signal. |
| startedStep | A function that is executed before the execution of every node. |

### `getWires(to:)`

```swift
private func getWires(to node: Int) -> [Wire]
```

Get the wires to a specified node.
- Parameter node: The node's index in ``allNodes(input:output:)``.
- Returns: An array containing the wires.

#### Parameters

| Name | Description |
| ---- | ----------- |
| node | The node’s index in `allNodes(input:output:)`. |