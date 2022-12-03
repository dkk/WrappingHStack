import SwiftUI

// based on https://swiftui.diegolavalle.com/posts/linewrapping-stacks/
struct InternalWrappingHStack: View {
    let width: CGFloat
    let alignment: HorizontalAlignment
    let spacing: WrappingHStack.Spacing
    let content: [WrappingHStack.ViewType]
    let firstItemOfEachLine: [Int]
    let lineSpacing: CGFloat

    init(width: CGFloat, alignment: HorizontalAlignment, spacing: WrappingHStack.Spacing, lineSpacing: CGFloat, content: [WrappingHStack.ViewType]) {
        self.width = width
        self.alignment = alignment
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.content = content

        firstItemOfEachLine = content
            .enumerated()
            .reduce((firstItemOfEachLine: [], currentLineWidth: width)) { (result, contentIterator) -> (firstItemOfEachLine: [Int], currentLineWidth: CGFloat) in
                var (firstItemOfEachLine, currentLineWidth) = result
                
                switch contentIterator.element {
                case .newLine:
                    return (firstItemOfEachLine + [contentIterator.offset], width)
                case .any(let anyView) where Self.isVisible(view: anyView):
                    let itemWidth = Self.getWidth(of: anyView)
                    if result.currentLineWidth + itemWidth + spacing.minSpacing > width {
                        currentLineWidth = itemWidth
                        firstItemOfEachLine.append(contentIterator.offset)
                    } else {
                        currentLineWidth += itemWidth + spacing.minSpacing
                    }
                    return (firstItemOfEachLine, currentLineWidth)
                default:
                    return result
                }
            }.0
    }

    static func getWidth(of anyView: AnyView) -> Double {
#if os(iOS)
        let hostingController = UIHostingController(rootView: HStack { anyView })
#else
        let hostingController = NSHostingController(rootView: HStack { anyView })
#endif
        return hostingController.sizeThatFits(in: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
    }
    
    var totalLines: Int {
        firstItemOfEachLine.count
    }
    
    func startOf(line i: Int) -> Int {
        firstItemOfEachLine[i]
    }
    
    func endOf(line i: Int) -> Int {
        i == totalLines - 1 ? content.count - 1 : firstItemOfEachLine[i + 1] - 1
    }
    
    func hasExactlyOneElement(line i: Int) -> Bool {
        startOf(line: i) == endOf(line: i)
    }
    
    func shouldHaveSideSpacers(line i: Int) -> Bool {
        if case .constant = spacing {
            return true
        }
        if case .dynamic = spacing, hasExactlyOneElement(line: i) {
            return true
        }
        return false
    }

    @inline(__always) static func isVisible(view: AnyView) -> Bool {
#if os(iOS)
        return UIHostingController(rootView: view).sizeThatFits(in: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width > 0
#else
        return NSHostingController(rootView: view).sizeThatFits(in: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width > 0
#endif
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: lineSpacing) {
            ForEach(0 ..< totalLines, id: \.self) { lineIndex in
                HStack(spacing: 0) {
                    if alignment == .center || alignment == .trailing, shouldHaveSideSpacers(line: lineIndex) {
                        Spacer(minLength: 0)
                    }
                    
                    ForEach(startOf(line: lineIndex) ... endOf(line: lineIndex), id: \.self) {
                        if case .dynamicIncludingBorders = spacing,
                           startOf(line: lineIndex) == $0
                        {
                            Spacer(minLength: spacing.minSpacing)
                        }
                        
                        if case .any(let anyView) = content[$0], Self.isVisible(view: anyView) {
                            anyView
                        }
                        
                        if endOf(line: lineIndex) != $0 {
                            if case .any(let anyView) = content[$0], !Self.isVisible(view: anyView) { } else {
                                if case .constant(let exactSpacing) = spacing {
                                    Spacer(minLength: 0)
                                        .frame(width: exactSpacing)
                                } else {
                                    Spacer(minLength: spacing.minSpacing)
                                }
                            }
                        } else if case .dynamicIncludingBorders = spacing {
                            Spacer(minLength: spacing.minSpacing)
                        }
                    }
                    
                    if alignment == .center || alignment == .leading, shouldHaveSideSpacers(line: lineIndex) {
                        Spacer(minLength: 0)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
