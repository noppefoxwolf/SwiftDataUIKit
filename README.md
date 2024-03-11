# SwiftDataUIKit

## Description
SwiftData extensions for UIKit.

## Installation
To integrate a package into your Swift project using Swift Package Manager, add the package's URL to your `Package.swift` file as a dependency:

```swift
dependencies: [
    .package(url: "https://url-to-package", from: "1.0.0")
]
```

# Usage

## Setup

Put @ViewQuery instead @Query in your view.

```swift
@ViewQuery(FetchDescriptor<User>())
var users: [User]
```

ViewQuery need to load view and ModelContainer.

```swift
_users.load(view, modelContainer: modelContainer)
```

## Observe

`$users` is a Combine publisher. Any solution can be observe.

### Combine
```swift
$users.sink { ... }.store(in: $cancellables)
```

### Swift Concurrency
```swift
Task {
    for await users in $users.values { ... }
}
```

## Mechanism

ViewQuery embeds QueryView when you call load().
QueryView is a SwiftUI view. That has a EmptyView and onChange modifier.
When the query is changed, the onChange modifier is called and publisher send.

# Required

- iOS 17+

# License

SwiftDataUIKit is available under the MIT license. See the LICENSE file for more info.