import SwiftUI

/// This class manages content and the calculation of their widths (reusing it).
/// It should be reused whenever possible.
class ContentManager {
    enum ViewType {
        case any(AnyView)
        case newLine

        init<V: View>(rawView: V) {
            switch rawView {
            case is NewLine: self = .newLine
            default: self = .any(AnyView(rawView))
            }
        }
    }

    let items: [ViewType]
    lazy var widths: [Double] = {
        items.map {
            if case let .any(anyView) = $0 {
                return Self.getWidth(of: anyView)
            } else {
                return 0
            }
        }
    }()

    init(items: [ViewType]) {
        self.items = items
    }

    @inline(__always) private static func getWidth(of anyView: AnyView) -> Double {
#if os(iOS)
        let hostingController = UIHostingController(rootView: HStack { anyView })
#else
        let hostingController = NSHostingController(rootView: HStack { anyView })
#endif
        return hostingController.sizeThatFits(in: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
    }
    
    func isVisible(viewIndex: Int) -> Bool {
        widths[viewIndex] > 0
    }
}
