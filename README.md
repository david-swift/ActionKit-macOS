<p align="center">
  <img width="256" alt="ActionKit Icon" src="Icons/ActionKitIcon.png">
  <h1 align="center">ActionKit</h1>
</p>

<p align="center">
  <a href="https://github.com/david-swift/ActionKit-macOS">
  GitHub
  </a>
  ·
  <a href="Documentation/Reference/ActionKit/README.md">
  Contributor Docs
  </a>
</p>

_ActionKit_ contains an editor for visual scripting. The developer can provide functions the user can use as nodes, the input and output parameters and run the function defined by the user. It is also possible to add custom data types that conform to the `ActionType` protocol.

![GitHub Banner][image-1]

## Table of Contents

- [Elements][1]
- [Installation][2]
- [Usage][3]
- [Thanks][4]

## Elements

| Name            | Description                                                                                               |
| --------------- | --------------------------------------------------------------------------------------------------------- |
| Function Editor | Provide functions and input and output parameters that the user can use for creating scripts using nodes. |
| Canvas Editor   | A 2D scroll view with a background, a rectangle for selecting items and items to display.                 |

## Installation

### Swift Package
1. Open your Swift package in Xcode.
2. Navigate to `File > Add Packages`.
3. Paste this URL into the search field: `https://github.com/david-swift/ActionKit-macOS`
4. Click on `Copy Dependency`.
5. Navigate to the `Package.swift` file.
6. In the `Package` initializer, under `dependencies`, paste the dependency into the array.

###  Xcode Project
1. Open your Xcode project in Xcode.
2. Navigate to `File > Add Packages`.
3. Paste this URL into the search field: `https://github.com/david-swift/ActionKit-macOS`
4. Click on `Add Package`.

## Usage

### Function
You first need to define the function that the user can edit. You need to define a function identifier, name and description. 
```swift
@State private var function = Function(
    id: "user-function",
    name: "User Function",
    description: "A function defined by the user"
)
```

#### Additional Parameters
_The following snippets show additional parameters for initializing a function._

If you want to provide data the user has access to, add input parameters.
```swift
// ...
input: [
    .init("Name", type: String.self),
    .init("Age", type: Double.self),
    .init("Profession", type: Profession.self)
]
// ...
```

If you want to get output from the user, add output parameters.
```swift
// ...
output: [
    .init("Adult", type: Bool.self)
]
// ...
```

If you do not provide functions for the user, function will add a default set with functions for text, numbers, booleans and the control flow. You can provide custom functions. 
Here is an example of a custom function group „My Functions“ containing a function for printing text into the console.
```swift
// ...
functions: [
    .init("My Functions", icon: .init("my-functions") {
        Function(
            id: "print",
            name: "Print",
            description: "Print text",
            input: [.init("Text", type: String.self)]
        ) {
            print(input.first as? String ?? "-")
            return []
        }
    }
]
// ...
```

You can also access the default set (`[Folder<Function>.default`), parts of the default set (`.numberFunctions`, `.textFunctions`, `.booleanFunctions`, `.controlFlowFunctions`, `.mergeFlowGroup`) or even parts of those sets and add them to your functions.

### Function Editor
Now that you have defined the function the user can define, it’s time to use the `FunctionEditor` in a SwiftUI view.
```swift
var body: some View {
    FunctionEditor($function)
}
```

#### Additional Parameters
_The following snippets show additional parameters for initializing the function editor._

You can change the size of the function editor.
```swift
// ...
zoom: 0.4
// ...
```

You can define whether the view for grabbing functions is visible or if it is a viewer instead of an editor.
```swift
// ...
functionsView: false
// ...
```

You can define an action that is executed when the user wants to open a node. If it is not defined, the button for opening a node is hidden.
```swift
// ...
openNode: { node in
    // Open the node
}
// ...
```

It is also possible to add actions that are always visible in the editor as buttons. For example, you could add a run button or a button for deleting the selected nodes.
```swift
// ...
extraActions: {
    TaggedView(tag: "run") {
        // The run button
    }
}
// ...
```

#### Modifiers
_There are also some modifiers for the function editor._

Provide a `Binding` that is always updated with the node’s selection. If you edit the value, the selection will change.
```swift
// ...
.observeSelection(value: $selection)
```

Provide a `Binding` that is always updated when the node actions’ visibility changes. If you edit the value, the visibility will change.
```swift
// ...
.observeActions(value: $actionsVisibility)
```

Provide a `Binding` that is always updated when the expansion of the functions view changes. If you edit the value, the expansion will change.
```swift
// ...
.observeExpandFunctions(value: $expandFunctions)
```

You can throw an error by providing a `Binding`. If the wrapped value changes to another `String?` value than `nil`, the error is displayed in the editor.
```swift
// ...
.throwError(error: $error)
```

### Running the Function
You can run the function defined by the user. The input values should match the parameters defined as the function’s input.
If everything works fine, you get the function’s output as `[ActionType]`, else, the function throws an error.
```swift
let output = try function.run(input: ["Peter", 23, Profession.developer])
```

#### Additional Parameters
_The following snippets show additional parameters for running a function._

Observe the function’s state by always getting the node’s index when the execution of a new node starts.
```swift
// ...
startedStep: { index in
    // Do something
}
// ...
```

### Codable Function
You might want to save a function so it stays the same even after restarting the app or add a function to a document. You can accomplish that with `CodableFunction`, a wrapper around `Function` that makes it conform to `Codable`. 

Information defined by the developer and that cannot be changed as for example the available functions have to be stored as static variables in a separate type conforming to the `CodableFunctionInformation` protocol. This type is also used by the function’s encoder and decoder to encoder or decode an action type. As you as the developer know every available type in the functions (do not forget `ControlFlow`), you can try to convert the type value to its real type and with that create an encoder and decoder. Here is an example. You can find a working example in the [TestApp][5].
```swift
// ...
init(from decoder: Decoder) throws {
    let decoder = try decoder.singleValueContainer()
    if let value = try? decoder.decode(String.self) {
        self.init(type: value)
    } else if let value = try? decoder.decode(Double.self) {
        self.init(type: value
    } else if let value = try? decoder.decode(Bool.self) {
    // ...
}

func encode(to encoder: Encoder) throws {
    var encoder = encoder.singleValueContainer()
    if let string = type as? String {
        try encoder.encode(string)
    } else if let double = type as? Double {
        try encoder.encode(double)
    } else if let boolean = type as? Bool {
    // ...
}
// ...
```

## Thanks

### Dependencies
-  [SFSafeSymbols][6] licensed under the [MIT license][7]
- [SwiftLintPlugin][8] licensed under the [MIT license][9]
- [ColibriComponents][10] licensed under the [MIT license][11]

### Other Thanks
- The [contributors][12]
- [SourceDocs][13] used for generating the [docs][14]
- [SwiftLint][15] for checking whether code style conventions are violated
- AudioKit: File [NodeEditor+Drawing.swift][16] in the [AudioKit/Flow][17] GitHub repository
- The programming language [Swift][18]

[1]:	#Elements
[2]:	#Installation
[3]:	#Usage
[4]:	#Thanks
[5]:	Tests/ActionKitTests/TestApp/
[6]:	https://github.com/SFSafeSymbols/SFSafeSymbols
[7]:	https://github.com/SFSafeSymbols/SFSafeSymbols/blob/stable/LICENSE
[8]:	https://github.com/lukepistrol/SwiftLintPlugin
[9]:	https://github.com/lukepistrol/SwiftLintPlugin/blob/main/LICENSE
[10]:	https://github.com/david-swift/ColibriComponents-macOS
[11]:	https://github.com/david-swift/ColibriComponents-macOS/blob/main/LICENSE.md
[12]:	Contributors.md
[13]:	https://github.com/SourceDocs/SourceDocs
[14]:	Documentation/Reference/ActionKit/README.md
[15]:	https://github.com/realm/SwiftLint
[16]:	https://github.com/AudioKit/Flow/blob/main/Sources/Flow/Views/NodeEditor+Drawing.swift
[17]:	https://github.com/AudioKit/Flow
[18]:	https://github.com/apple/swift

[image-1]:	Icons/GitHubBanner.png