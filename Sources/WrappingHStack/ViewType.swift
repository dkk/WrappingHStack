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
}
