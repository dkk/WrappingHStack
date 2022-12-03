import SwiftUI

@main
struct WrappingHStackExampleApp: App {
    var body: some Scene {
        WindowGroup {
            contentView
        }
    }

    public var contentView: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if !ProcessInfo.processInfo.arguments.contains(where: { $0.starts(with: "performanceTests") }) {
                    ForEach(ExampleView.ExampleType.allCases.filter({ $0 != .long && $0 != .longHStack }), id: \.self) {
                        Text($0.rawValue)
                            .font(.title)
                            .padding(.horizontal)

                        ExampleView(exampleType: $0)

                        Divider()
                    }
                }

                if !ProcessInfo.processInfo.arguments.contains("performanceTests_HS") {
                    NavigationView {
                        VStack {
                            NavigationLink("Long WrappingHStack") {
                                NavigationView {
                                    ExampleView(exampleType: .long)
                                }
                            }
                        }
                    }
                }

                if ProcessInfo.processInfo.arguments.contains("performanceTests_HS") {
                    NavigationView {
                        VStack {
                            NavigationLink("Long HStack") {
                                NavigationView {
                                    ExampleView(exampleType: .longHStack)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
