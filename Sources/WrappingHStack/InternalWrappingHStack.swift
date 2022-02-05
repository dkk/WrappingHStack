import SwiftUI

// based on https://swiftui.diegolavalle.com/posts/linewrapping-stacks/
struct InternalWrappingHStack: View {
    let width: CGFloat
    let alignment: HorizontalAlignment
    let spacing: WrappingHStack.Spacing
    let content: [WrappingHStack.ViewType]
    let firstItemOfEachLane: [Int]
    let lineSpacing: CGFloat

    init(width: CGFloat, alignment: HorizontalAlignment, spacing: WrappingHStack.Spacing, lineSpacing: CGFloat, content: [WrappingHStack.ViewType]) {
        self.width = width
        self.alignment = alignment
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.content = content

        firstItemOfEachLane = content
            .enumerated()
            .reduce((firstItems: [], currentLineWidth: width)) { (result, contentIterator) -> (firstItemOfEachLane: [Int], currentLineWidth: CGFloat) in
                var (firstItemOfEachLane, currentLineWidth) = result
                
                switch contentIterator.element {
                case .newLine:
                    return (firstItemOfEachLane + [contentIterator.offset], width)
                case .any(let anyView):
                    #if os(iOS)
                    let hostingController = UIHostingController(rootView: HStack(spacing: spacing.estimatedSpacing) { anyView })
                    #else
                    let hostingController = NSHostingController(rootView: HStack(spacing: spacing.estimatedSpacing) { anyView })
                    #endif
                    
                    let itemWidth = hostingController.view.intrinsicContentSize.width
                    
                    if result.currentLineWidth + itemWidth + spacing.estimatedSpacing > width {
                        currentLineWidth = itemWidth
                        firstItemOfEachLane.append(contentIterator.offset)
                    } else {
                        currentLineWidth += itemWidth + spacing.estimatedSpacing
                    }
                    return (firstItemOfEachLane, currentLineWidth)
                }
            }.0
    }
    
    var totalLanes: Int {
        firstItemOfEachLane.count
    }
    
    func startOf(lane i: Int) -> Int {
        firstItemOfEachLane[i]
    }
    
    func endOf(lane i: Int) -> Int {
        i == totalLanes - 1 ? content.count - 1 : firstItemOfEachLane[i + 1] - 1
    }
    
    func hasExactlyOneElement(lane i: Int) -> Bool {
        startOf(lane: i) == endOf(lane: i)
    }
    
    func shouldHaveSideSpacers(lane i: Int) -> Bool {
        if case .constant = spacing {
            return true
        }
        if case .dynamic = spacing, hasExactlyOneElement(lane: i) {
            return true
        }
        return false
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: lineSpacing) {
            ForEach(0 ..< totalLanes, id: \.self) { laneIndex in               
                HStack(spacing: 0) {
                    if alignment == .center || alignment == .trailing, shouldHaveSideSpacers(lane: laneIndex) {
                        Spacer(minLength: 0)
                    }
                    
                    ForEach(startOf(lane: laneIndex) ... endOf(lane: laneIndex), id: \.self) {
                        if case .dynamicIncludingBorders = spacing,
                           startOf(lane: laneIndex) == $0
                        {
                            Spacer(minLength: spacing.estimatedSpacing)
                        }
                        
                        if case .any(let anyView) = content[$0] {
                            anyView
                        }
                        
                        if endOf(lane: laneIndex) != $0 {
                            if case .constant(let exactSpacing) = spacing {
                                Spacer(minLength: 0)
                                    .frame(width: exactSpacing)
                            } else {
                                Spacer(minLength: spacing.estimatedSpacing)
                            } 
                        } else if case .dynamicIncludingBorders = spacing {
                            Spacer(minLength: spacing.estimatedSpacing)
                        }
                    }
                    
                    if alignment == .center || alignment == .leading, shouldHaveSideSpacers(lane: laneIndex) {
                        Spacer(minLength: 0)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
