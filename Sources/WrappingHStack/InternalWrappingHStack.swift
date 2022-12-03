import SwiftUI

// based on https://swiftui.diegolavalle.com/posts/linewrapping-stacks/
struct InternalWrappingHStack: View {
    let width: CGFloat
    let alignment: HorizontalAlignment
    let spacing: WrappingHStack.Spacing
    let content: [WrappingHStack.ViewType]
    let lineSpacing: CGFloat
    let lineManager: LineManager

    init(width: CGFloat, alignment: HorizontalAlignment, spacing: WrappingHStack.Spacing, lineSpacing: CGFloat, content: [WrappingHStack.ViewType], lineManager: LineManager) {
        self.width = width
        self.alignment = alignment
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.content = content
        self.lineManager = lineManager

        if !lineManager.isSetUp {
            lineManager.setup(content: content, width: width, spacing: spacing)
        }
    }

    @inline(__always) static func getWidth(of anyView: AnyView) -> Double {
#if os(iOS)
        let hostingController = UIHostingController(rootView: HStack { anyView })
#else
        let hostingController = NSHostingController(rootView: HStack { anyView })
#endif
        return hostingController.sizeThatFits(in: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
    }
    
    func shouldHaveSideSpacers(line i: Int) -> Bool {
        if case .constant = spacing {
            return true
        }
        if case .dynamic = spacing, lineManager.hasExactlyOneElement(line: i) {
            return true
        }
        return false
    }

    @inline(__always) static func isVisible(view: AnyView) -> Bool {
        getWidth(of: view) > 0
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: lineSpacing) {
            ForEach(0 ..< lineManager.totalLines, id: \.self) { lineIndex in
                HStack(spacing: 0) {
                    if alignment == .center || alignment == .trailing, shouldHaveSideSpacers(line: lineIndex) {
                        Spacer(minLength: 0)
                    }
                    
                    ForEach(lineManager.startOf(line: lineIndex) ... lineManager.endOf(line: lineIndex), id: \.self) {
                        if case .dynamicIncludingBorders = spacing,
                           lineManager.startOf(line: lineIndex) == $0
                        {
                            Spacer(minLength: spacing.minSpacing)
                        }
                        
                        if case .any(let anyView) = content[$0], Self.isVisible(view: anyView) {
                            anyView
                        }
                        
                        if lineManager.endOf(line: lineIndex) != $0 {
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
