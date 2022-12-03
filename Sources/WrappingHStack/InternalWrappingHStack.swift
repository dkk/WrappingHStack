import SwiftUI

/// This View draws the WrappingHStack content taking into account the passed width, alignment and spacings.
/// Note that the passed LineManager and ContentManager should be reused whenever possible.
struct InternalWrappingHStack: View {
    let alignment: HorizontalAlignment
    let spacing: WrappingHStack.Spacing
    let lineSpacing: CGFloat
    let lineManager: LineManager
    let contentManager: ContentManager

    init(width: CGFloat, alignment: HorizontalAlignment, spacing: WrappingHStack.Spacing, lineSpacing: CGFloat, lineManager: LineManager, contentManager: ContentManager) {
        self.alignment = alignment
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.contentManager = contentManager
        self.lineManager = lineManager

        if !lineManager.isSetUp {
            lineManager.setup(contentManager: contentManager, width: width, spacing: spacing)
        }
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
                        
                        if case .any(let anyView) = contentManager.items[$0], contentManager.isVisible(viewIndex: $0) {
                            anyView
                        }
                        
                        if lineManager.endOf(line: lineIndex) != $0 {
                            if case .any = contentManager.items[$0], !contentManager.isVisible(viewIndex: $0) { } else {
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
