import Foundation

/// This class calculates which items should be on which lines
class LineManager {
    private var content: [WrappingHStack.ViewType]!
    private var spacing: WrappingHStack.Spacing!
    private var width: CGFloat!

    lazy var firstItemOfEachLine: [Int] = {
        content
            .enumerated()
            .reduce((firstItemOfEachLine: [], currentLineWidth: width)) { (result, contentIterator) -> (firstItemOfEachLine: [Int], currentLineWidth: CGFloat) in
                var (firstItemOfEachLine, currentLineWidth) = result

                switch contentIterator.element {
                case .newLine:
                    return (firstItemOfEachLine + [contentIterator.offset], width)
                case .any(let anyView) where InternalWrappingHStack.isVisible(view: anyView):
                    let itemWidth = InternalWrappingHStack.getWidth(of: anyView)
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
    }()

    var isSetUp: Bool {
        width != nil
    }

    func setup(content: [WrappingHStack.ViewType], width: CGFloat, spacing: WrappingHStack.Spacing) {
        self.content = content
        self.width = width
        self.spacing = spacing
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
}
