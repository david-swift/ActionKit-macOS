<p align="center">
  <img width="256" alt="ActionKit Icon" src="Icons/ActionKitIcon.png">
  <h1 align="center">ActionKit</h1>
</p>

<p align="center">
  <a href="https://david-swift.github.io/ActionKit-macOS">
  Documentation
  </a>
  ·
  <a href="https://github.com/david-swift/ActionKit-macOS">
  GitHub
  </a>
</p>

_ActionKit_ contains an editor for visual scripting. The developer can provide functions the user can use as nodes, the input and output parameters and run the function defined by the user. It is also possible to add custom data types that conform to the `ActionType` protocol.

![GitHub Banner][image-1]

## Table of Contents

- [Installation][1]
- [Usage][2]
- [Thanks][3]

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

Information on how to use the package is available in the [documentation](https://david-swift.github.io/ActionKit-macOS/documentation/actionkit/gettingstarted#Usage).

## Thanks

### Dependencies
- [SwiftLintPlugin][7] licensed under the [MIT license][8]

### Other Thanks
- [SwiftLint][14] for checking whether code style conventions are violated
- AudioKit: File [NodeEditor+Drawing.swift][15] in the [AudioKit/Flow][16] GitHub repository
- The programming language [Swift][17]

[1]:	#installation
[2]:	#usage
[3]:	#thanks
[4]:	Tests/ActionKitTests/TestApp/
[5]:	https://github.com/SFSafeSymbols/SFSafeSymbols
[6]:	https://github.com/SFSafeSymbols/SFSafeSymbols/blob/stable/LICENSE
[7]:	https://github.com/lukepistrol/SwiftLintPlugin
[8]:	https://github.com/lukepistrol/SwiftLintPlugin/blob/main/LICENSE
[9]:	https://github.com/david-swift/ColibriComponents-macOS
[10]:	https://github.com/david-swift/ColibriComponents-macOS/blob/main/LICENSE.md
[12]:	https://github.com/SourceDocs/SourceDocs
[13]:	Documentation/Reference/ActionKit/README.md
[14]:	https://github.com/realm/SwiftLint
[15]:	https://github.com/AudioKit/Flow/blob/main/Sources/Flow/Views/NodeEditor+Drawing.swift
[16]:	https://github.com/AudioKit/Flow
[17]:	https://github.com/apple/swift

[image-1]:	Icons/GitHubBanner.png
