# WrappingHStack

WrappingHStack is a UI Element that works in a very similar way to HStack, but automatically positions overflowing elements on next lines.

## Example

![Example](./example.png?raw=true)
```swift
WrappingHStack {
    Text("WrappingHStack")
        .padding()
        .font(.title)
        .border(Color.black)
    
    Text("can handle different element types")
    
    Image(systemName: "scribble")
        .font(.title)
        .frame(width: 200, height: 20)
        .background(Color.purple)
    
    Text("and loop")
        .bold()
    
    WrappingHStack(1...20, id:\.self) {
        Text("Item: \($0)")
            .padding(3)
            .background(Rectangle().stroke())
    }.frame(minWidth: 250)
}
.padding()
.border(Color.black)
```

## Installation
Requirements iOS 13+

### Swift Package Manager 
1. In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency.
2. Paste the repository URL (https://github.com/dkk/WrappingHStack) and click Next.
3. For Rules, select version.
4. Click Finish.

### Swift Package
```swift
.package(url: "https://github.com/dkk/WrappingHStack", .upToNextMajor(from: "2.0.0"))
```
## Usage

Import the WrappingHStack package to your view:
```swift
import WrappingHStack
```

use it like you would use HStack for single elements:
```swift
WrappingHStack {
    /* some views */
    NewLine() // Optional: Use NewLine to force the next element to be placed in a next line
    /* some more views */
}
```

or like a ForEach to loop over items:
```swift
WrappingHStack(1...30, id:\.self) {
    Text("Item: \($0)")
}
```

### Item positioning

You control the position of the items by using the parameter `alignment`, which sets the `HorizontalAlignment` of the items. I.e. leading, trailing or centered.

For even more convenience and flexibility, `WrappingHSTack` offers the parameter `spacing`, that defines how the spacing will be calculated. It can be one of the following types:
* `.constant`: for fixed spacing, each line starts with an item and the horizontal separation between any 2 items is the given value.
* `.dynamic`: to have the items fill the width of the WrappingHSTack. You can pass a minimal spacing.
* `.dynamicIncludingBorders` to fill the full width with equal spacing between items and from the items to the border. You can pass a minimal spacing.

## Known Issues

* [Issue #15](https://github.com/dkk/WrappingHStack/issues/15): Item sizes are calculated incorrectly when WrappingHStack has modifiers that change the size of its elements.
* [Issue #17](https://github.com/dkk/WrappingHStack/issues/17): Spacing always applied around conditional views, even when they're missing.
* [Issue #16](https://github.com/dkk/WrappingHStack/issues/26): Workaround needed when using `WrappingHStack` in a `NavigationLink` (iOS16 only).
* [Issue #10](https://github.com/dkk/WrappingHStack/issues/10): SPM cannot resolve the dependency (Xcode 11.3.1 only).

## Contribute
You can contribute to this project by helping me solve any [reported issues or feature requests](https://github.com/dkk/WrappingHStack/issues) and creating a pull request.

## Support
If you just want to say thanks, you could [buy me a coffee ☕️](https://www.buymeacoffee.com/kloeck).

## License
WrappingHStack was originally developed by Daniel Klöck and is released under the [MIT License](LICENSE).
