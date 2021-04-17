import SwiftUI

/// WrappingHStack is a UI Element that works in a very similar way to HStack, but automatically positions overflowing elements on next lines.
/// It can be customized by using alignment (controls the alignment of the items, it will get ignored when combined with a `.dynamic` spacing
/// for all but last lines with single elements), spacing (use `.constant` for fixed spacing and `.dynamic` to have the items fill the width
/// of the WrappingHSTack)
public struct WrappingHStack: View {
    private struct CGFloatPreferenceKey: PreferenceKey {
        static var defaultValue = CGFloat.zero
        static func reduce(value: inout CGFloat , nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
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
    
    public enum Spacing {
        case constant(CGFloat)
        case dynamic(minSpacing: CGFloat)
        
        internal var estimatedSpacing: CGFloat {
            switch self {
            case .constant(let constantSpacing):
                return constantSpacing
            case .dynamic(minSpacing: let minSpacing):
                return minSpacing
            }
        }
    }
    
    var items: [ViewType]
    var alignment: HorizontalAlignment
    var spacing: Spacing
    @State private var height: CGFloat = 0
    
    public var body: some View {
        GeometryReader { geo in
            InternalWrappingHStack (
                width: geo.frame(in: .global).width,
                alignment: alignment,
                spacing: spacing,
                content: items
            )
            .anchorPreference(
                key: CGFloatPreferenceKey.self,
                value: .bounds,
                transform: {
                    geo[$0].size.height
                }
            )
        }
        .frame(height: height)
        .onPreferenceChange(CGFloatPreferenceKey.self, perform: {
            height = $0
        })
    }
}

// Convenience inits that allows 10 Elements (just like HStack).
// Based on https://alejandromp.com/blog/implementing-a-equally-spaced-stack-in-swiftui-thanks-to-tupleview/
public extension WrappingHStack {
    private static func viewType<V: View>(from view: V) -> ViewType {
        switch view {
        case is NewLine: return .newLine
        default: return .any(AnyView(view))
        }
    }
    
    /// Instatiates a WrappingHStack
    /// - Parameters:
    ///   - data: The items to show
    ///   - id: The `KeyPath` to use as id for the items   
    ///   - alignment: Controls the alignment of the items. This will get ignored when combined with a `.dynamic` spacing for all
    ///     but last lines with single elements
    ///   - spacing: Use `.constant` for fixed spacing and `.dynamic` to have the items fill the width of the WrappingHSTack
    init<Data: RandomAccessCollection, Content: View>(_ data: Data, id: KeyPath<Data.Element, Data.Element> = \.self, alignment: HorizontalAlignment = .leading, spacing: Spacing = .constant(8), content: @escaping (Data.Element) -> Content) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = data.map { Self.viewType(from: content($0[keyPath: id])) }
    }
    
    init<A: View>(alignment: HorizontalAlignment = .leading, spacing: Spacing = .constant(8), @ViewBuilder content: () -> A) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [Self.viewType(from: content())]
    }
    
    init<A: View, B: View>(alignment: HorizontalAlignment = .leading, spacing: Spacing = .constant(8), @ViewBuilder content: () -> TupleView<(A, B)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [Self.viewType(from: content().value.0),
                      Self.viewType(from: content().value.1)]
    }
    
    init<A: View, B: View, C: View>(alignment: HorizontalAlignment = .leading, spacing: Spacing = .constant(8), @ViewBuilder content: () -> TupleView<(A, B, C)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [Self.viewType(from: content().value.0),
                      Self.viewType(from: content().value.1),
                      Self.viewType(from: content().value.2)]
    }
    
    init<A: View, B: View, C: View, D: View>(alignment: HorizontalAlignment = .leading, spacing: Spacing = .constant(8), @ViewBuilder content: () -> TupleView<(A, B, C, D)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [Self.viewType(from: content().value.0),
                      Self.viewType(from: content().value.1),
                      Self.viewType(from: content().value.2),
                      Self.viewType(from: content().value.3)]
    }
    
    init<A: View, B: View, C: View, D: View, E: View>(alignment: HorizontalAlignment = .leading, spacing: Spacing = .constant(8), @ViewBuilder content: () -> TupleView<(A, B, C, D, E)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [Self.viewType(from: content().value.0),
                      Self.viewType(from: content().value.1),
                      Self.viewType(from: content().value.2),
                      Self.viewType(from: content().value.3),
                      Self.viewType(from: content().value.4)]
    }
    
    init<A: View, B: View, C: View, D: View, E: View, F: View>(alignment: HorizontalAlignment = .leading, spacing: Spacing = .constant(8), @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [Self.viewType(from: content().value.0),
                      Self.viewType(from: content().value.1),
                      Self.viewType(from: content().value.2),
                      Self.viewType(from: content().value.3),
                      Self.viewType(from: content().value.4),
                      Self.viewType(from: content().value.5)]
    }
    
    init<A: View, B: View, C: View, D: View, E: View, F: View, G: View>(alignment: HorizontalAlignment = .leading, spacing: Spacing = .constant(8), @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F, G)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [Self.viewType(from: content().value.0),
                      Self.viewType(from: content().value.1),
                      Self.viewType(from: content().value.2),
                      Self.viewType(from: content().value.3),
                      Self.viewType(from: content().value.4),
                      Self.viewType(from: content().value.5),
                      Self.viewType(from: content().value.6)]
    }
    
    init<A: View, B: View, C: View, D: View, E: View, F: View, G: View, H: View>(alignment: HorizontalAlignment = .leading, spacing: Spacing = .constant(8), @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F, G, H)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [Self.viewType(from: content().value.0),
                      Self.viewType(from: content().value.1),
                      Self.viewType(from: content().value.2),
                      Self.viewType(from: content().value.3),
                      Self.viewType(from: content().value.4),
                      Self.viewType(from: content().value.5),
                      Self.viewType(from: content().value.6),
                      Self.viewType(from: content().value.7)]
    }
    
    init<A: View, B: View, C: View, D: View, E: View, F: View, G: View, H: View, I: View>(alignment: HorizontalAlignment = .leading, spacing: Spacing = .constant(8), @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F ,G, H, I)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [Self.viewType(from: content().value.0),
                      Self.viewType(from: content().value.1),
                      Self.viewType(from: content().value.2),
                      Self.viewType(from: content().value.3),
                      Self.viewType(from: content().value.4),
                      Self.viewType(from: content().value.5),
                      Self.viewType(from: content().value.6),
                      Self.viewType(from: content().value.7),
                      Self.viewType(from: content().value.8)]
    }
    
    init<A: View, B: View, C: View, D: View, E: View, F: View, G: View, H: View, I: View, J: View>(alignment: HorizontalAlignment = .leading, spacing: Spacing = .constant(8), @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F ,G, H, I, J)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [Self.viewType(from: content().value.0),
                      Self.viewType(from: content().value.1),
                      Self.viewType(from: content().value.2),
                      Self.viewType(from: content().value.3),
                      Self.viewType(from: content().value.4),
                      Self.viewType(from: content().value.5),
                      Self.viewType(from: content().value.6),
                      Self.viewType(from: content().value.7),
                      Self.viewType(from: content().value.8),
                      Self.viewType(from: content().value.9)]
    }
}



