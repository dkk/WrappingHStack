import SwiftUI

public struct WrappingHStack: View {
    var items: [AnyView]
    var alignment: Alignment
    var spacing: CGFloat
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

// Allows 10 Elements, just like HStack does, based on https://alejandromp.com/blog/implementing-a-equally-spaced-stack-in-swiftui-thanks-to-tupleview/
public extension WrappingHStack {
    init<A: View>(alignment: Alignment = .top, spacing: CGFloat = 8, @ViewBuilder content: () -> A) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [AnyView(content())]
    }
    init<A: View, B: View>(alignment: Alignment = .top, spacing: CGFloat = 8, @ViewBuilder content: () -> TupleView<(A, B)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [AnyView(content().value.0),
                      AnyView(content().value.1)]
    }
    init<A: View, B: View, C: View>(alignment: Alignment = .top, spacing: CGFloat = 8, @ViewBuilder content: () -> TupleView<(A, B, C)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [AnyView(content().value.0),
                      AnyView(content().value.1),
                      AnyView(content().value.2)]
    }
    init<A: View, B: View, C: View, D: View>(alignment: Alignment = .top, spacing: CGFloat = 8, @ViewBuilder content: () -> TupleView<(A, B, C, D)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [AnyView(content().value.0),
                      AnyView(content().value.1),
                      AnyView(content().value.2),
                      AnyView(content().value.3)]
    }
    init<A: View, B: View, C: View, D: View, E: View>(alignment: Alignment = .top, spacing: CGFloat = 8, @ViewBuilder content: () -> TupleView<(A, B, C, D, E)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [AnyView(content().value.0),
                      AnyView(content().value.1),
                      AnyView(content().value.2),
                      AnyView(content().value.3),
                      AnyView(content().value.4)]
    }
    init<A: View, B: View, C: View, D: View, E: View, F: View>(alignment: Alignment = .top, spacing: CGFloat = 8, @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [AnyView(content().value.0),
                      AnyView(content().value.1),
                      AnyView(content().value.2),
                      AnyView(content().value.3),
                      AnyView(content().value.4),
                      AnyView(content().value.5)]
    }
    
    init<A: View, B: View, C: View, D: View, E: View, F: View, G: View>(alignment: Alignment = .top, spacing: CGFloat = 8, @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F, G)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [AnyView(content().value.0),
                      AnyView(content().value.1),
                      AnyView(content().value.2),
                      AnyView(content().value.3),
                      AnyView(content().value.4),
                      AnyView(content().value.5),
                      AnyView(content().value.6)]
    }
    init<A: View, B: View, C: View, D: View, E: View, F: View, G: View, H: View>(alignment: Alignment = .top, spacing: CGFloat = 8, @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F, G, H)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [AnyView(content().value.0),
                      AnyView(content().value.1),
                      AnyView(content().value.2),
                      AnyView(content().value.3),
                      AnyView(content().value.4),
                      AnyView(content().value.5),
                      AnyView(content().value.6),
                      AnyView(content().value.7)]
    }
    init<A: View, B: View, C: View, D: View, E: View, F: View, G: View, H: View, I: View>(alignment: Alignment = .top, spacing: CGFloat = 8, @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F ,G, H, I)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [AnyView(content().value.0),
                      AnyView(content().value.1),
                      AnyView(content().value.2),
                      AnyView(content().value.3),
                      AnyView(content().value.4),
                      AnyView(content().value.5),
                      AnyView(content().value.6),
                      AnyView(content().value.7),
                      AnyView(content().value.8)]
    }
    
    init<A: View, B: View, C: View, D: View, E: View, F: View, G: View, H: View, I: View, J: View>(alignment: Alignment = .center, spacing: CGFloat = 8, @ViewBuilder content: () -> TupleView<(A, B, C, D, E, F ,G, H, I, J)>) {
        self.spacing = spacing
        self.alignment = alignment
        self.items = [AnyView(content().value.0),
                      AnyView(content().value.1),
                      AnyView(content().value.2),
                      AnyView(content().value.3),
                      AnyView(content().value.4),
                      AnyView(content().value.5),
                      AnyView(content().value.6),
                      AnyView(content().value.7),
                      AnyView(content().value.8),
                      AnyView(content().value.9)]
    }
}

fileprivate struct CGFloatPreferenceKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout CGFloat , nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// based on https://swiftui.diegolavalle.com/posts/linewrapping-stacks/
fileprivate struct InternalWrappingHStack<Content: View>: View {
    var width: CGFloat
    var alignment: Alignment
    var spacing: CGFloat
    var content: [Content]
    
    var firstItems: [Int] {
        content.enumerated().reduce((firstItems: [], currentLineWidth: width)) { (result, contentIterator) -> (firstItems: [Int], currentLineWidth: CGFloat) in
            var (firstItems, currentLineWidth) = result
            
            #if os(iOS)
            let hostingController = UIHostingController(rootView: contentIterator.element)
            #else
            let hostingController = NSHostingController(rootView: contentIterator.element)
            #endif
            
            let itemWidth = hostingController.view.intrinsicContentSize.width
            
            if result.currentLineWidth + itemWidth + spacing > width {
                currentLineWidth = itemWidth
                firstItems.append(contentIterator.offset)
            } else {
                currentLineWidth += itemWidth + spacing
            }
            return (firstItems, currentLineWidth)
        }.0
    }
    
    var totalLanes: Int {
        firstItems.count
    }
    
    func startOf(lane i: Int) -> Int {
        firstItems[i]
    }
    
    func endOf(lane i: Int) -> Int {
        i == totalLanes - 1 ? content.count - 1 : firstItems[i + 1] - 1
    }
    
    var body: some View {
        VStack(alignment: alignment.horizontal) {
            ForEach(0 ..< totalLanes, id: \.self) { laneIndex in
                HStack(alignment: alignment.vertical, spacing: spacing) {
                    ForEach(startOf(lane: laneIndex) ... endOf(lane: laneIndex), id: \.self) {
                        content[$0]
                    }
                }
            }
        }
    }
}
