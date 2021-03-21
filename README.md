# WrappingHStack

![Example](./example.png?raw=true)

WrappingHStack is a UI Element that works in a very similar way to HStack, but automatically positioning overflowing elements on next lines.

## Installation
Requirements iOS 13+

### Swift Package Manager 
1. In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency.
2. Paste the repository URL (https://github.com/dkk/WrappingHStack) and click Next.
3. For Rules, select version.
4. Click Finish.

### Swift Package
```swift
.package(url: "https://github.com/dkk/WrappingHStack", .upToNextMajor(from: "1.0.0"))
```
## Usage

Import the WrappingHStack package to your view.

```swift
import StarRating
```

Use it like you would use HStack for single elements:
```swift
WrappingHStack {
    /* contained views */
}
```

or like a ForEach to loop over items:
```swift
WrappingHStack(data: 1...30, id:\.self) {
    Text("Item: \($0)")
}
```

## License

WrappingHStack is released under the [MIT License](LICENSE).

