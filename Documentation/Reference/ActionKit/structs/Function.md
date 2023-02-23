**STRUCT**

# `Function`

```swift
public struct Function: Identifiable, Equatable, Bindable
```

A function that can be edited in the ``FunctionEditor`` or executed.

## Properties
### `id`

```swift
public let id: String
```

The function's identifier.

### `name`

```swift
var name: String
```

The function's name.

### `description`

```swift
var description: String
```

A short description of the function.

### `dataInput`

```swift
private(set) var dataInput: [Parameter]
```

The input parameters.

### `dataOutput`

```swift
private(set) var dataOutput: [Parameter]
```

The output parameters.

### `input`

```swift
var input: [Parameter]
```

The input parameters with the control flow.

### `output`

```swift
var output: [Parameter]
```

The output parameters with the control flow.

### `controlFlow`

```swift
let controlFlow: Parameter = .init(
    .init(localized: .init("Control Flow", comment: "Function (The control flow parameter name)") ),
    type: ControlFlow.self,
    id: .controlFlowID
)
```

The control flow parameter.

### `getOutput`

```swift
var getOutput: (([ActionType]) -> [ActionType])?
```

The function for getting the output for functions defined by the developer.
Nil in functions defined by the user.

### `nodes`

```swift
private(set) var nodes: [Node]
```

The nodes in the function.

### `inputNodePosition`

```swift
private(set) var inputNodePosition: CGPoint
```

The position of the input node in the ``FunctionEditor``.

### `outputNodePosition`

```swift
private(set) var outputNodePosition: CGPoint
```

The position of the output node in the ``FunctionEditor``.

### `outputNodeValues`

```swift
private(set) var outputNodeValues: [Int: ActionType]
```

Values for the output node that are defined manually.

### `wires`

```swift
var wires: [Wire]
```

The connections between the nodes.

### `requireOnlyOneInput`

```swift
var requireOnlyOneInput: Bool
```

Whether the function requires only one input or all the inputs to run.
This input is then given as the first input.
There is no way to build such a function with nodes.

### `groupedFunctions`

```swift
var groupedFunctions: [Folder<Function>]
```

The functions that the nodes can access ordered in groups.

### `functions`

```swift
var functions: [Function]
```

The functions that the nodes can access.

### `width`

```swift
var width: CGFloat
```

The function nodes' witdth in the ``FunctionEditor``.

### `inputNode`

```swift
private var inputNode: Node
```

The input node.

### `outputNode`

```swift
private var outputNode: Node
```

The output node.
- Parameter output: Function for getting the input values of the output node.
- Returns: The output node.

### `allNodes`

```swift
var allNodes: [Node]
```

Get all the available nodes for the function including input and output.

### `editableAllFunctions`

```swift
var editableAllFunctions: [Function]
```

``allFunctions(input:output:)`` without the input and output specified with a setter.
It is ideal for editing and viewing the functions, but not for executing the whole function.

### `maxCount`

```swift
var maxCount: Int
```

The number of inputs if there are more inputs than outputs
or the number of outputs otherwise.

## Methods
### `init(id:name:description:input:output:getOutput:nodes:wires:functions:)`

```swift
public init(
    id: String,
    name: String,
    description: String,
    input: [Parameter] = [],
    output: [Parameter] = [],
    getOutput: ( ([ActionType]) -> [ActionType])? = nil,
    nodes: [Node] = [],
    wires: [Wire] = [],
    functions: [Folder<Function>] = .init()
)
```

The function's initializer.
- Parameters:
  - id: The function's id.
  - name: The function's name.
  - description: A short description of the function.
  - input: The input parameters.
  - output: The output parameters.
  - getOutput: The function for getting the output in a function defined by the developer.
  - nodes: The nodes in a function defined by the user.
  - wires: The wires in a function defined by the user.
  - functions: The functions available for the user for defining the parent function.

#### Parameters

| Name | Description |
| ---- | ----------- |
| id | The function’s id. |
| name | The function’s name. |
| description | A short description of the function. |
| input | The input parameters. |
| output | The output parameters. |
| getOutput | The function for getting the output in a function defined by the developer. |
| nodes | The nodes in a function defined by the user. |
| wires | The wires in a function defined by the user. |
| functions | The functions available for the user for defining the parent function. |

### `init(functionID:name:description:input:output:getOutput:nodes:wires:functions:outputNodeValues:width:inputNodePosition:outputNodePosition:)`

```swift
init(
    functionID: String,
    name: String,
    description: String,
    input: [Parameter] = [],
    output: [Parameter] = [],
    getOutput: ( ([ActionType]) -> [ActionType])? = nil,
    nodes: [Node] = [],
    wires: [Wire] = [],
    functions: [Folder<Function>] = .init(),
    outputNodeValues: [Int: ActionType] = [0: ControlFlow.signal],
    width: CGFloat = 150,
    inputNodePosition: CGPoint = .init(
        x: .halfEditorSideLength - .standardNodePositionXOffset,
        y: .halfEditorSideLength + .standardNodePositionYOffset
    ),
    outputNodePosition: CGPoint = .init(
        x: .halfEditorSideLength + .standardNodePositionXOffset,
        y: .halfEditorSideLength - .standardNodePositionYOffset
    )
)
```

The function's initializer.
- Parameters:
  - functionID: The function's id.
  - name: The function's name.
  - description: A short description of the function.
  - input: The input parameters.
  - output: The output parameters.
  - getOutput: The function for getting the output in a function defined by the developer.
  - nodes: The nodes in a function defined by the user.
  - wires: The wires in a function defined by the user.
  - functions: The functions available for the user for defining the parent function.
  - outputNodeValues: The manually defined values of the output node.
  - width: The node's width.

#### Parameters

| Name | Description |
| ---- | ----------- |
| functionID | The function’s id. |
| name | The function’s name. |
| description | A short description of the function. |
| input | The input parameters. |
| output | The output parameters. |
| getOutput | The function for getting the output in a function defined by the developer. |
| nodes | The nodes in a function defined by the user. |
| wires | The wires in a function defined by the user. |
| functions | The functions available for the user for defining the parent function. |
| outputNodeValues | The manually defined values of the output node. |
| width | The node’s width. |

### `==(_:_:)`

```swift
public static func == (lhs: Function, rhs: Function) -> Bool
```

Check whether two functions are equal.
- Parameters:
  - lhs: The first function.
  - rhs: The second function.
- Returns: Whether the two functions are equal.

#### Parameters

| Name | Description |
| ---- | ----------- |
| lhs | The first function. |
| rhs | The second function. |

### `allFunctions(input:output:)`

```swift
func allFunctions(input: [ActionType], output: @escaping ([ActionType]) -> Void) -> [Function]
```

The functions with the input and output function.
- Parameters:
  - input: The output of the input node.
  - output: Get the input of the output node.
- Returns: The functions.

#### Parameters

| Name | Description |
| ---- | ----------- |
| input | The output of the input node. |
| output | Get the input of the output node. |

### `inputFunction(input:)`

```swift
private func inputFunction(input: [ActionType]) -> Function
```

The function for the input node.
- Parameter input: The input node's output values.
- Returns: The function.

#### Parameters

| Name | Description |
| ---- | ----------- |
| input | The input node’s output values. |

### `outputFunction(output:)`

```swift
private func outputFunction(output: @escaping ([ActionType]) -> Void) -> Function
```

The function for the output node.
- Parameter output: The function for handling the output node's input values.
- Returns: The function.

#### Parameters

| Name | Description |
| ---- | ----------- |
| output | The function for handling the output node’s input values. |