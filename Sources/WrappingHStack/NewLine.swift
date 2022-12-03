import SwiftUI

/// Use this item to force a line break in a WrappingHStack
public struct NewLine: View {
    public init() { }
    public let body = Spacer(minLength: .infinity)
}
