import Foundation

/// This class manages content and the calculation of their widths (reusing it).
/// It should be reused whenever possible.
class ContentManager {
    let items: [ViewType]
    let getWidths: () -> [Double]
    lazy var widths: [Double] = {
        getWidths()
    }()

    init(items: [ViewType], getWidths: @escaping () -> [Double]) {
        self.items = items
        self.getWidths = getWidths
    }
    
    func isVisible(viewIndex: Int) -> Bool {
        widths[viewIndex] > 0
    }
}
