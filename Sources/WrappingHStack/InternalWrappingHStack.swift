import SwiftUI

// based on https://swiftui.diegolavalle.com/posts/linewrapping-stacks/
struct InternalWrappingHStack<Content: View>: View {
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
            
            // Bug: returns the width of only the first element if it is a Group or ForEach
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
