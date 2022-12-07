import Foundation

/// This class is in charge of calculating which items fit on which lines.
/// It should be reused whenever possible.
class LineManager {
    private var contentManager: ContentManager!
    private var spacing: WrappingHStack.Spacing!
    private var width: Double!

    lazy var firstItemOfEachLine: [Int] = {
        var firstOfEach = [Int]()
        var currentWidth: Double = width
        for (index, element) in contentManager.items.enumerated() {
            switch element {
            case .newLine:
                firstOfEach += [index]
                currentWidth = width
            case .any where contentManager.isVisible(viewIndex: index):
                let itemWidth = contentManager.widths[index]
                if currentWidth + itemWidth + spacing.minSpacing > width {
                    currentWidth = itemWidth
                    firstOfEach.append(index)
                } else {
                    currentWidth += itemWidth + spacing.minSpacing
                }
            default:
                break
            }
        }

        return firstOfEach
    }()

    var isSetUp: Bool {
        width != nil
    }

    func setup(contentManager: ContentManager, width: Double, spacing: WrappingHStack.Spacing) {
        self.contentManager = contentManager
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
        i == totalLines - 1 ? contentManager.items.count - 1 : firstItemOfEachLine[i + 1] - 1
    }

    func hasExactlyOneElement(line i: Int) -> Bool {
        startOf(line: i) == endOf(line: i)
    }
}
