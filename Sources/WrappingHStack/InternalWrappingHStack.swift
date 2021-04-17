import SwiftUI

// based on https://swiftui.diegolavalle.com/posts/linewrapping-stacks/
struct InternalWrappingHStack: View {
    var width: CGFloat
    var alignment: HorizontalAlignment
    var spacing: WrappingHStack.Spacing
    var content: [WrappingHStack.ViewType]
    
    var firstItems: [Int] {
        return content.enumerated().reduce((firstItems: [], currentLineWidth: width)) { (result, contentIterator) -> (firstItems: [Int], currentLineWidth: CGFloat) in
            var (firstItems, currentLineWidth) = result
            
            switch contentIterator.element {
            case .newLine:
                return (firstItems + [contentIterator.offset], 0)
            case .any(let anyView):
                #if os(iOS)
                let hostingController = UIHostingController(rootView: HStack(spacing: spacing.estimatedSpacing) { anyView })
                #else
                let hostingController = NSHostingController(rootView: HStack(spacing: spacing.estimatedSpacing) { anyView })
                #endif
                
                let itemWidth = hostingController.view.intrinsicContentSize.width
                
                if result.currentLineWidth + itemWidth + spacing.estimatedSpacing > width {
                    currentLineWidth = itemWidth
                    firstItems.append(contentIterator.offset)
                } else {
                    currentLineWidth += itemWidth + spacing.estimatedSpacing
                }
                return (firstItems, currentLineWidth)
            }
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
    
    private func line(laneIndex: Int) -> some View {
        HStack(spacing: spacing.estimatedSpacing) {
            ForEach(startOf(lane: laneIndex) ... endOf(lane: laneIndex), id: \.self) {
                if case .any(let anyView) = content[$0] {
                    anyView
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: 0) {
            ForEach(0 ..< totalLanes, id: \.self) { laneIndex in
                if case .constant = spacing {
                    line(laneIndex: laneIndex)
                } else if laneIndex == totalLanes - 1 && startOf(lane: laneIndex) == endOf(lane: laneIndex) {
                    line(laneIndex: laneIndex)
                } else {
                    HStack(spacing: 0) {
                        ForEach(startOf(lane: laneIndex) ... endOf(lane: laneIndex), id: \.self) {
                            if case .any(let anyView) = content[$0] {
                                anyView
                            }
                            
                            if endOf(lane: laneIndex) != $0 {
                                Spacer(minLength: spacing.estimatedSpacing)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}
