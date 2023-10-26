import SwiftUI

enum ViewType {
    case any(AnyView)
    case newLine

    init<V: View>(rawView: V) {
        switch rawView {
        case is NewLine: self = .newLine
        default: self = .any(AnyView(rawView))
        }
    }

    init<V: View>(conditionalContent: V) {
        if conditionalContent.isConditionalNewLine() {
            self = .newLine
        } else {
            self.init(rawView: conditionalContent)
        }
    }
}

extension View {
    /// Hack to find whether or not a view inside a loop-based init is a new-line.
    /// As opposed to the `TupleView`-based approach of the other init,
    /// the view returned by `content`in the loop-based init is type-erased as a `_ConditionalContent` type
    /// unfortunately, we don't have access to any underlying values, so all we can do is evaluate description of `self`
    /// - Returns: boolean value indicating whether the object is a `NewLine` wrapped in a `_ConditionalContent` struct
    fileprivate func isConditionalNewLine() -> Bool {
        String(describing: self).hasPrefix("_ConditionalContent")
        && ((String(describing: self).contains("<NewLine")
             && String(describing: self).contains("Storage.trueContent(WrappingHStack.NewLine"))
            || (String(describing: self).contains("NewLine>")
                && String(describing: self).contains("Storage.falseContent(WrappingHStack.NewLine")))
    }
}

